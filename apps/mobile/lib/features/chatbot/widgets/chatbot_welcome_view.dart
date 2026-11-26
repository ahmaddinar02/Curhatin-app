import 'package:flutter/material.dart';
import '../theme/chatbot_theme.dart';

/// Tampilan awal sebelum user mengirim pesan:
/// Ilustrasi Athena di tengah + sapaan hangat.
class ChatbotWelcomeView extends StatelessWidget {
  const ChatbotWelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 230,
              height: 230,
              child: Image.asset(
                'assets/images/chatbot_logo.png',
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: ChatbotColors.primarySoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.smart_toy_outlined,
                    size: 64,
                    color: ChatbotColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Halo, ada yang ingin kamu\ntanyakan...?',
              textAlign: TextAlign.center,
              style: ChatbotTextStyles.welcomeTitle,
            ),
          ],
        ),
      ),
    );
  }
}
