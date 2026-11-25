import 'package:flutter/material.dart';
import '../models/comment_model.dart';
import '../theme/forum_theme.dart';
import 'forum_common_widgets.dart';

class ReplyItem extends StatelessWidget {
  final ReplyModel reply;
  final VoidCallback onLike;

  const ReplyItem({
    super.key,
    required this.reply,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 44, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reply connector line
          Container(
            width: 2,
            height: 36,
            margin: const EdgeInsets.only(right: 10, top: 2),
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          // Avatar
          _buildAvatar(),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.surfaceGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        reply.userName,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 6),
                      TimeAgoText(dateTime: reply.createdAt),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(reply.content, style: AppTextStyles.bodySmall),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: onLike,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          reply.isLiked
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 14,
                          color: reply.isLiked
                              ? AppColors.likeActive
                              : AppColors.likeInactive,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${reply.likeCount}',
                          style: AppTextStyles.caption.copyWith(
                            color: reply.isLiked
                                ? AppColors.likeActive
                                : AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: 28,
      height: 28,
      child: ClipOval(
        child: Image.network(
          reply.userAvatar,
          fit: BoxFit.cover,
          errorBuilder: (ctx, err, stack) => Container(
            color: AppColors.primarySurface,
            child: Center(
              child: Text(
                reply.userName.isNotEmpty ? reply.userName[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
