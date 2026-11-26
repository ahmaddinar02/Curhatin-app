import 'dart:async';

import 'package:flutter/material.dart';
import '../data/athena_responder.dart';
import '../data/dummy_chat_history.dart';
import '../models/chat_message_model.dart';
import '../theme/chatbot_theme.dart';
import '../widgets/chat_history_dialog.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chatbot_background.dart';
import '../widgets/chatbot_input_bar.dart';
import '../widgets/chatbot_welcome_view.dart';

/// Halaman utama fitur Chatbot Athena.
class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  late List<ChatSessionModel> _sessions;
  String? _activeSessionId;
  List<ChatMessageModel> _messages = [];
  bool _isBotTyping = false;
  Timer? _replyTimer;

  @override
  void initState() {
    super.initState();
    _sessions = DummyChatHistory.createInitialSessions();
  }

  @override
  void dispose() {
    _replyTimer?.cancel();
    _inputController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage([String? presetText]) {
    final text = (presetText ?? _inputController.text).trim();
    if (text.isEmpty || _isBotTyping) return;

    if (presetText == null) {
      _inputController.clear();
    }

    final now = DateTime.now();
    final userMsg = ChatMessageModel(
      id: 'u_${now.microsecondsSinceEpoch}',
      text: text,
      sender: ChatSender.user,
      timestamp: now,
    );

    setState(() {
      _messages = [..._messages, userMsg];
      _isBotTyping = true;
      _upsertActiveSession(firstUserText: text, updatedAt: now);
    });

    _scrollToBottom();

    _replyTimer?.cancel();
    _replyTimer = Timer(const Duration(milliseconds: 550), () {
      if (!mounted) return;
      final replyTime = DateTime.now();
      final reply = AthenaResponder.replyTo(text);
      final botMsg = ChatMessageModel(
        id: 'b_${replyTime.microsecondsSinceEpoch}',
        text: reply,
        sender: ChatSender.bot,
        timestamp: replyTime,
      );

      setState(() {
        _isBotTyping = false;
        _messages = [..._messages, botMsg];
        _upsertActiveSession(updatedAt: replyTime);
      });
      _scrollToBottom();
    });
  }

  void _upsertActiveSession({
    String? firstUserText,
    required DateTime updatedAt,
  }) {
    if (_activeSessionId == null) {
      final newId = 's_${updatedAt.microsecondsSinceEpoch}';
      final title = _buildSessionTitle(firstUserText ?? 'Percakapan baru');
      _activeSessionId = newId;
      _sessions.insert(
        0,
        ChatSessionModel(
          id: newId,
          title: title,
          updatedAt: updatedAt,
          messages: List<ChatMessageModel>.from(_messages),
        ),
      );
      return;
    }

    final index = _sessions.indexWhere((s) => s.id == _activeSessionId);
    if (index != -1) {
      final updated = _sessions[index].copyWith(
        updatedAt: updatedAt,
        messages: List<ChatMessageModel>.from(_messages),
      );
      _sessions.removeAt(index);
      _sessions.insert(0, updated);
    }
  }

  String _buildSessionTitle(String text) {
    final cleaned = text.replaceAll('\n', ' ').trim();
    if (cleaned.length <= 32) return cleaned;
    return '${cleaned.substring(0, 32).trimRight()}...';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void _startNewConversation() {
    _replyTimer?.cancel();
    setState(() {
      _activeSessionId = null;
      _messages = [];
      _isBotTyping = false;
    });
  }

  void _deleteCurrentConversation() {
    _replyTimer?.cancel();
    final removedId = _activeSessionId;
    setState(() {
      if (removedId != null) {
        _sessions.removeWhere((s) => s.id == removedId);
      }
      _activeSessionId = null;
      _messages = [];
      _isBotTyping = false;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Percakapan dihapus'),
          backgroundColor: ChatbotColors.primary,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 84),
        ),
      );
  }

  void _selectHistorySession(ChatSessionModel session) {
    _replyTimer?.cancel();
    setState(() {
      _activeSessionId = session.id;
      _messages = List<ChatMessageModel>.from(session.messages);
      _isBotTyping = false;
    });
    _scrollToBottom();
  }

  void _openHistoryPopup() {
    _focusNode.unfocus();
    showChatHistoryPopup(
      context: context,
      sessions: _sessions,
      activeSessionId: _activeSessionId,
      onNewConversation: _startNewConversation,
      onSelectSession: _selectHistorySession,
    );
  }

  void _onMicTap() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Input suara akan tersedia segera'),
          backgroundColor: ChatbotColors.primary,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 84),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final lastBotIndex = _messages.lastIndexWhere((m) => !m.isUser);

    return Scaffold(
      backgroundColor: ChatbotColors.backgroundBottom,
      body: ChatbotBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildTopBar(context),
              Expanded(
                child: GestureDetector(
                  onTap: () => _focusNode.unfocus(),
                  behavior: HitTestBehavior.translucent,
                  child: _messages.isEmpty
                      ? const ChatbotWelcomeView()
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: _messages.length + (_isBotTyping ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (_isBotTyping && index == _messages.length) {
                              return const BotTypingIndicator();
                            }
                            final message = _messages[index];
                            final showMascot = !_isBotTyping &&
                                !message.isUser &&
                                index == lastBotIndex;
                            return ChatMessageBubble(
                              message: message,
                              showMascot: showMascot,
                            );
                          },
                        ),
                ),
              ),
              ChatbotInputBar(
                controller: _inputController,
                focusNode: _focusNode,
                onSend: _sendMessage,
                onMenuTap: _openHistoryPopup,
                onMicTap: _onMicTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: ChatbotColors.surfaceWhite,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: ChatbotColors.primaryDark,
                size: 18,
              ),
            ),
          ),
          const Spacer(),
          if (_messages.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: ChatbotColors.primary,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: ChatbotColors.primary.withValues(alpha: 0.28),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: _startNewConversation,
                    child: const Tooltip(
                      message: 'Percakapan baru',
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.edit_square,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: _deleteCurrentConversation,
                    child: const Tooltip(
                      message: 'Hapus percakapan',
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.white,
                          size: 21,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
