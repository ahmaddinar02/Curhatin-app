import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2B7AFC);
  static const Color primaryLight = Color(0xFF5B9FE8);
  static const Color primaryDark = Color(0xFF1A5FA6);
  static const Color primarySurface = Color(0xFFE8F1FB);

  // Background Colors
  static const Color background = Color(0xFFF5F7FA);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceGrey = Color(0xFFF0F2F5);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Accent Colors
  static const Color likeActive = Color(0xFFEF4444);
  static const Color likeInactive = Color(0xFF9CA3AF);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color cardBorder = Color(0xFFEEF0F3);

  // Category Colors
  static const Color categoryKecemasan = Color(0xFFFEF3C7);
  static const Color categoryKecemasanText = Color(0xFFD97706);
  static const Color categoryBurnout = Color(0xFFFFEDED);
  static const Color categoryBurnoutText = Color(0xFFDC2626);
  static const Color categorySelfCare = Color(0xFFD1FAE5);
  static const Color categorySelfCareText = Color(0xFF059669);
  static const Color categoryDefault = Color(0xFFE8F1FB);
  static const Color categoryDefaultText = Color(0xFF2D7DD2);
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );
}
