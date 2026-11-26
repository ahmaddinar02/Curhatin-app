import 'package:flutter/material.dart';

/// Palet warna dan tipografi untuk fitur Chatbot Athena.
class ChatbotColors {
  static const Color primary = Color(0xFF2B7AFC);
  static const Color primaryDark = Color(0xFF1B5CD6);
  static const Color primarySoft = Color(0xFFE8F1FF);
  static const Color backgroundTop = Color(0xFFE7F1FF);
  static const Color backgroundBottom = Color(0xFFF6FAFF);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color bubbleLight = Color(0xFF8EC0FF);
  static const Color bubbleMid = Color(0xFF68A9FF);
}

class ChatbotTextStyles {
  static const TextStyle welcomeTitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 19,
    fontWeight: FontWeight.w600,
    color: ChatbotColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle messageText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );

  static const TextStyle hintText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: ChatbotColors.textHint,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: ChatbotColors.textSecondary,
  );
}
