import 'package:flutter/material.dart';
import '../theme/chatbot_theme.dart';

/// Bar input bawah dengan tombol menu bulat di kiri (`=`) dan pill input
/// berisi text field, ikon mikrofon, dan tombol kirim bulat biru.
class ChatbotInputBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSend;
  final VoidCallback onMenuTap;
  final VoidCallback onMicTap;

  const ChatbotInputBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSend,
    required this.onMenuTap,
    required this.onMicTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Row(
          children: [
            // Tombol menu bulat putih dengan ikon `=` biru
            GestureDetector(
              onTap: onMenuTap,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: ChatbotColors.surfaceWhite,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4A90D9).withValues(alpha: 0.14),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.drag_handle_rounded,
                  color: ChatbotColors.primary,
                  size: 26,
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Pill input pesan
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(left: 18, right: 6),
                decoration: BoxDecoration(
                  color: ChatbotColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4A90D9).withValues(alpha: 0.14),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        focusNode: focusNode,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => onSend(),
                        style: ChatbotTextStyles.messageText.copyWith(
                          color: ChatbotColors.textPrimary,
                          fontSize: 13,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Apa yang sedang kamu rasakan saat ini...',
                          hintStyle: ChatbotTextStyles.hintText,
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onMicTap,
                      splashRadius: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 34,
                        minHeight: 34,
                      ),
                      icon: const Icon(
                        Icons.mic_none_rounded,
                        color: ChatbotColors.textSecondary,
                        size: 21,
                      ),
                    ),
                    const SizedBox(width: 2),
                    GestureDetector(
                      onTap: onSend,
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: const BoxDecoration(
                          color: ChatbotColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
