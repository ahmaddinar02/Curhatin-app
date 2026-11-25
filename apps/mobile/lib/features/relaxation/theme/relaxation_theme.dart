import 'package:flutter/material.dart';

/// Konstanta warna & teks khusus fitur Relaxation.
/// Menggunakan primary color yang sama dengan forum (#2B7AFC).
class RelaxationColors {
  static const Color primary = Color(0xFF2B7AFC);
  static const Color primaryLight = Color(0xFF5B9FE8);
  static const Color primaryDark = Color(0xFF1A5FA6);
  static const Color primarySurface = Color(0xFFE8F1FB);

  // Hero gradient — langit biru cerah sesuai referensi UI
  static const Color heroGradientTop = Color(0xFFB8D9FF);
  static const Color heroGradientBottom = Color(0xFFE8F3FF);

  static const Color background = Color(0xFFF5F7FA);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color cardBorder = Color(0xFFEEF0F3);
  static const Color cardShadow = Color(0x0D000000);

  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);

  // Warna per kategori (untuk highlight kecil)
  static const Color meditation = Color(0xFFDEEAFF);
  static const Color music = Color(0xFFEDE9FF);
  static const Color breathing = Color(0xFFD6F5EC);
  static const Color story = Color(0xFFFFF3DC);
  static const Color reading = Color(0xFFFFE8E8);
}

class RelaxationTextStyles {
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Color(0xFF1A1A2E),
    letterSpacing: 1.2,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Color(0xFF1A1A2E),
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: Color(0xFF1A1A2E),
  );

  static const TextStyle cardDescription = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xFF6B7280),
    height: 1.4,
  );

  static const TextStyle cardAction = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Color(0xFF2B7AFC),
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF1A1A2E),
    height: 1.6,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xFF9CA3AF),
  );
}
