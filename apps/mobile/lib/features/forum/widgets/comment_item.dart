import 'package:flutter/material.dart';
import '../models/comment_model.dart';
import '../theme/forum_theme.dart';
import 'forum_common_widgets.dart';
import 'reply_item.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback onLike;
  final VoidCallback onReply;
  final VoidCallback onToggleReplies;
  final Function(String, String) onLikeReply;

  const CommentItem({
    super.key,
    required this.comment,
    required this.onLike,
    required this.onReply,
    required this.onToggleReplies,
    required this.onLikeReply,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceGrey,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                comment.userName,
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              TimeAgoText(dateTime: comment.createdAt),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(comment.content, style: AppTextStyles.bodySmall),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Action row: Like + Reply
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: onLike,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  comment.isLiked
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  size: 16,
                                  color: comment.isLiked
                                      ? AppColors.likeActive
                                      : AppColors.likeInactive,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${comment.likeCount} Suka',
                                  style: AppTextStyles.caption.copyWith(
                                    color: comment.isLiked
                                        ? AppColors.likeActive
                                        : AppColors.textTertiary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: onReply,
                            child: Text(
                              'Balas',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (comment.replies.isNotEmpty) ...[
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: onToggleReplies,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    comment.showReplies
                                        ? Icons.keyboard_arrow_up_rounded
                                        : Icons.keyboard_arrow_down_rounded,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                  Text(
                                    comment.showReplies
                                        ? 'Sembunyikan balasan'
                                        : '${comment.replies.length} balasan',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Replies
          if (comment.showReplies && comment.replies.isNotEmpty)
            ...comment.replies.map((reply) => ReplyItem(
                  reply: reply,
                  onLike: () => onLikeReply(comment.id, reply.id),
                )),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: 36,
      height: 36,
      child: ClipOval(
        child: Image.network(
          comment.userAvatar,
          fit: BoxFit.cover,
          errorBuilder: (ctx, err, stack) => Container(
            color: AppColors.primarySurface,
            child: Center(
              child: Text(
                comment.userName.isNotEmpty
                    ? comment.userName[0].toUpperCase()
                    : '?',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
