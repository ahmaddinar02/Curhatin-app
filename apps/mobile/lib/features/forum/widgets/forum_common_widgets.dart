import 'package:flutter/material.dart';
import '../theme/forum_theme.dart';

class CategoryBadge extends StatelessWidget {
  final String category;

  const CategoryBadge({super.key, required this.category});

  Color get _bgColor {
    switch (category.toLowerCase()) {
      case 'kecemasan':
        return AppColors.categoryKecemasan;
      case 'burnout':
        return AppColors.categoryBurnout;
      case 'self-care':
        return AppColors.categorySelfCare;
      default:
        return AppColors.categoryDefault;
    }
  }

  Color get _textColor {
    switch (category.toLowerCase()) {
      case 'kecemasan':
        return AppColors.categoryKecemasanText;
      case 'burnout':
        return AppColors.categoryBurnoutText;
      case 'self-care':
        return AppColors.categorySelfCareText;
      default:
        return AppColors.categoryDefaultText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category,
        style: AppTextStyles.labelMedium.copyWith(color: _textColor),
      ),
    );
  }
}

class TimeAgoText extends StatelessWidget {
  final DateTime dateTime;

  const TimeAgoText({super.key, required this.dateTime});

  String get _timeAgo {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) return 'Baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    if (diff.inDays < 7) return '${diff.inDays} hari lalu';
    return '${(diff.inDays / 7).floor()} minggu lalu';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeAgo,
      style: AppTextStyles.caption,
    );
  }
}
