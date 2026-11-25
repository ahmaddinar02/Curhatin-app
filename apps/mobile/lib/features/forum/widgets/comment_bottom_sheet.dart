import 'package:flutter/material.dart';
import '../models/comment_model.dart';
import '../theme/forum_theme.dart';
import 'comment_item.dart';
import 'comment_input.dart';

class CommentBottomSheet extends StatefulWidget {
  final String discussionId;
  final List<CommentModel> initialComments;
  final Function(int newCount) onCommentCountChanged;

  const CommentBottomSheet({
    super.key,
    required this.discussionId,
    required this.initialComments,
    required this.onCommentCountChanged,
  });

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  late List<CommentModel> _comments;
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String? _replyingToCommentId;
  String? _replyingToName;

  @override
  void initState() {
    super.initState();
    // Deep copy comments so mutations don't affect original list
    _comments = widget.initialComments
        .map((c) => CommentModel(
              id: c.id,
              discussionId: c.discussionId,
              userId: c.userId,
              userName: c.userName,
              userAvatar: c.userAvatar,
              content: c.content,
              createdAt: c.createdAt,
              likeCount: c.likeCount,
              isLiked: c.isLiked,
              showReplies: c.showReplies,
              replies: List<ReplyModel>.from(c.replies),
            ))
        .toList();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleLikeComment(String commentId) {
    setState(() {
      final idx = _comments.indexWhere((c) => c.id == commentId);
      if (idx != -1) {
        final c = _comments[idx];
        c.isLiked = !c.isLiked;
        c.likeCount += c.isLiked ? 1 : -1;
      }
    });
  }

  void _toggleLikeReply(String commentId, String replyId) {
    setState(() {
      final cIdx = _comments.indexWhere((c) => c.id == commentId);
      if (cIdx != -1) {
        final rIdx =
            _comments[cIdx].replies.indexWhere((r) => r.id == replyId);
        if (rIdx != -1) {
          final r = _comments[cIdx].replies[rIdx];
          r.isLiked = !r.isLiked;
          r.likeCount += r.isLiked ? 1 : -1;
        }
      }
    });
  }

  void _toggleReplies(String commentId) {
    setState(() {
      final idx = _comments.indexWhere((c) => c.id == commentId);
      if (idx != -1) {
        _comments[idx].showReplies = !_comments[idx].showReplies;
      }
    });
  }

  void _setReplyingTo(String commentId, String userName) {
    setState(() {
      _replyingToCommentId = commentId;
      _replyingToName = userName;
    });
    _focusNode.requestFocus();
  }

  void _cancelReply() {
    setState(() {
      _replyingToCommentId = null;
      _replyingToName = null;
    });
  }

  void _sendComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      if (_replyingToCommentId != null) {
        // Add reply to specific comment
        final idx =
            _comments.indexWhere((c) => c.id == _replyingToCommentId);
        if (idx != -1) {
          final newReply = ReplyModel(
            id: 'r_${DateTime.now().millisecondsSinceEpoch}',
            commentId: _replyingToCommentId!,
            userId: 'current_user',
            userName: 'Aku',
            userAvatar: 'https://i.pravatar.cc/150?img=1',
            content: text,
            createdAt: DateTime.now(),
            likeCount: 0,
            isLiked: false,
          );
          _comments[idx].replies.insert(0, newReply);
          _comments[idx].showReplies = true;
        }
        _replyingToCommentId = null;
        _replyingToName = null;
      } else {
        // Add new top-level comment
        final newComment = CommentModel(
          id: 'c_${DateTime.now().millisecondsSinceEpoch}',
          discussionId: widget.discussionId,
          userId: 'current_user',
          userName: 'Aku',
          userAvatar: 'https://i.pravatar.cc/150?img=1',
          content: text,
          createdAt: DateTime.now(),
          likeCount: 0,
          isLiked: false,
          replies: [],
          showReplies: false,
        );
        _comments.insert(0, newComment);
        widget.onCommentCountChanged(_comments.length);
      }
    });

    _commentController.clear();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surfaceWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 4),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      'Komentar',
                      style: AppTextStyles.heading2,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_comments.length}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceGrey,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(height: 1, color: AppColors.divider),

              // Comment list
              Expanded(
                child: _comments.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.only(top: 8, bottom: 12),
                        itemCount: _comments.length,
                        itemBuilder: (context, index) {
                          final comment = _comments[index];
                          return CommentItem(
                            comment: comment,
                            onLike: () => _toggleLikeComment(comment.id),
                            onReply: () =>
                                _setReplyingTo(comment.id, comment.userName),
                            onToggleReplies: () =>
                                _toggleReplies(comment.id),
                            onLikeReply: _toggleLikeReply,
                          );
                        },
                      ),
              ),

              // Input
              CommentInputField(
                controller: _commentController,
                focusNode: _focusNode,
                replyingToName: _replyingToName,
                onCancelReply: _cancelReply,
                onSend: _sendComment,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline_rounded,
            size: 56,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 12),
          Text(
            'Belum ada komentar',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Jadilah yang pertama memberikan komentar!',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}
