import 'package:flutter/material.dart';
import '../models/chat_message_model.dart';
import '../theme/chatbot_theme.dart';

/// Pop-up panel kiri yang menampilkan maksimal 10 riwayat chat terakhir,
/// tombol kembali, tombol "Percakapan baru", dan logo Curhatin di bawah.
Future<void> showChatHistoryPopup({
  required BuildContext context,
  required List<ChatSessionModel> sessions,
  required String? activeSessionId,
  required VoidCallback onNewConversation,
  required ValueChanged<ChatSessionModel> onSelectSession,
}) {
  final recentSessions = sessions.take(10).toList();

  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Tutup riwayat chat',
    barrierColor: Colors.black.withValues(alpha: 0.25),
    transitionDuration: const Duration(milliseconds: 240),
    pageBuilder: (dialogContext, _, _) {
      return _ChatHistoryPanel(
        recentSessions: recentSessions,
        activeSessionId: activeSessionId,
        onClose: () => Navigator.of(dialogContext).pop(),
        onNewConversation: () {
          Navigator.of(dialogContext).pop();
          onNewConversation();
        },
        onSelectSession: (session) {
          Navigator.of(dialogContext).pop();
          onSelectSession(session);
        },
      );
    },
    transitionBuilder: (_, animation, _, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      );
    },
  );
}

class _ChatHistoryPanel extends StatelessWidget {
  final List<ChatSessionModel> recentSessions;
  final String? activeSessionId;
  final VoidCallback onClose;
  final VoidCallback onNewConversation;
  final ValueChanged<ChatSessionModel> onSelectSession;

  const _ChatHistoryPanel({
    required this.recentSessions,
    required this.activeSessionId,
    required this.onClose,
    required this.onNewConversation,
    required this.onSelectSession,
  });

  @override
  Widget build(BuildContext context) {
    final panelWidth = MediaQuery.of(context).size.width * 0.72;

    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: ChatbotColors.surfaceWhite,
        elevation: 12,
        child: SizedBox(
          width: panelWidth,
          height: double.infinity,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header: tombol back + pill "Percakapan baru"
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: onClose,
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: ChatbotColors.surfaceWhite,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.10),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: ChatbotColors.primary,
                            size: 19,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: onNewConversation,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: ChatbotColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.edit_square,
                                color: Colors.white,
                                size: 15,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Percakapan baru',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFF9CA3AF),
                  ),
                ),

                // Daftar 10 chat terakhir
                Expanded(
                  child: recentSessions.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              'Belum ada riwayat chat',
                              textAlign: TextAlign.center,
                              style: ChatbotTextStyles.caption.copyWith(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          itemCount: recentSessions.length,
                          itemBuilder: (context, index) {
                            final session = recentSessions[index];
                            final isSelected = session.id == activeSessionId;

                            return InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () => onSelectSession(session),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? ChatbotColors.primarySoft
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  session.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? ChatbotColors.primaryDark
                                        : ChatbotColors.textPrimary,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),

                // Footer logo Curhatin
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Center(
                    child: Image.asset(
                      'assets/images/curhatinlogo2.png',
                      height: 32,
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => const Text(
                        'Curhatin',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: ChatbotColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
