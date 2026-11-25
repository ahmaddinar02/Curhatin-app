import 'package:flutter/material.dart';
import '../models/discussion_model.dart';
import '../theme/forum_theme.dart';
import 'forum_common_widgets.dart';

class DiscussionCard extends StatelessWidget {
  final DiscussionModel discussion;
  final VoidCallback onLike;
  final VoidCallback onComment;

  const DiscussionCard({
    super.key,
    required this.discussion,
    required this.onLike,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Avatar + Name + Time + Category
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAvatar(),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              discussion.userName,
                              style: AppTextStyles.heading3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          CategoryBadge(category: discussion.category),
                        ],
                      ),
                      const SizedBox(height: 2),
                      TimeAgoText(dateTime: discussion.createdAt),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Content
            Text(
              discussion.content,
              style: AppTextStyles.bodyMedium,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),

            // Image (if any)
            if (discussion.imageUrl != null) ...[
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  discussion.imageUrl!,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => const SizedBox.shrink(),
                ),
              ),
            ],

            const SizedBox(height: 14),

            // Divider
            Divider(color: AppColors.divider, height: 1),

            const SizedBox(height: 10),

            // Action Bar: Like + Comment
            Row(
              children: [
                _ActionButton(
                  icon: discussion.isLiked
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  iconColor: discussion.isLiked
                      ? AppColors.likeActive
                      : AppColors.likeInactive,
                  label: '${discussion.likeCount}',
                  labelColor: discussion.isLiked
                      ? AppColors.likeActive
                      : AppColors.textSecondary,
                  onTap: onLike,
                ),
                const SizedBox(width: 8),
                _ActionButton(
                  icon: Icons.chat_bubble_outline_rounded,
                  iconColor: AppColors.textSecondary,
                  label: '${discussion.commentCount}',
                  labelColor: AppColors.textSecondary,
                  onTap: onComment,
                ),
                const Spacer(),
                Icon(
                  Icons.bookmark_border_rounded,
                  size: 20,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3), width: 2),
      ),
      child: ClipOval(
        child: Image.network(
          discussion.userAvatar,
          fit: BoxFit.cover,
          errorBuilder: (ctx, err, stack) => Container(
            color: AppColors.primarySurface,
            child: Center(
              child: Text(
                discussion.userName.isNotEmpty
                    ? discussion.userName[0].toUpperCase()
                    : '?',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Color labelColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.labelColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.surfaceGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
