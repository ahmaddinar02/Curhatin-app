import 'package:flutter/material.dart';
import '../models/chat_message_model.dart';
import '../theme/chatbot_theme.dart';

/// Bubble pesan percakapan antara user dan Athena.
/// Bubble aplikasi tidak menampilkan avatar profil, namun menampilkan
/// maskot Curhatin di bawah balasan terakhir aplikasi.
class ChatMessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  final bool showMascot;

  const ChatMessageBubble({
    super.key,
    required this.message,
    this.showMascot = false,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        isUser ? 16 : 16,
        6,
        16,
        showMascot ? 4 : 6,
      ),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Align(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.76,
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isUser
                      ? ChatbotColors.primary
                      : ChatbotColors.surfaceWhite,
                  borderRadius: isUser
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(4),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4A90D9).withValues(alpha: 0.10),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  message.text,
                  style: ChatbotTextStyles.messageText.copyWith(
                    color: isUser ? Colors.white : ChatbotColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
          if (!isUser && showMascot) ...[
            const SizedBox(height: 8),
            const _MascotBadge(),
          ],
        ],
      ),
    );
  }
}

/// Indikator saat Athena sedang mengetik balasan (tanpa avatar profil).
class BotTypingIndicator extends StatelessWidget {
  const BotTypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
            decoration: BoxDecoration(
              color: ChatbotColors.surfaceWhite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4A90D9).withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'Athena sedang mengetik...',
              style: ChatbotTextStyles.caption,
            ),
          ),
          const SizedBox(height: 8),
          const _MascotBadge(),
        ],
      ),
    );
  }
}

class _MascotBadge extends StatelessWidget {
  const _MascotBadge();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Image.asset(
        'assets/image/maskot.png',
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) => const Icon(
          Icons.emoji_emotions_outlined,
          size: 32,
          color: ChatbotColors.primary,
        ),
      ),
    );
  }
}
