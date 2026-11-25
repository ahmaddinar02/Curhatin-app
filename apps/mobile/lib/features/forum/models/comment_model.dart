class ReplyModel {
  final String id;
  final String commentId;
  final String userId;
  final String userName;
  final String userAvatar;
  final String content;
  final DateTime createdAt;
  int likeCount;
  bool isLiked;

  ReplyModel({
    required this.id,
    required this.commentId,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.content,
    required this.createdAt,
    this.likeCount = 0,
    this.isLiked = false,
  });
}

class CommentModel {
  final String id;
  final String discussionId;
  final String userId;
  final String userName;
  final String userAvatar;
  final String content;
  final DateTime createdAt;
  int likeCount;
  bool isLiked;
  List<ReplyModel> replies;
  bool showReplies;

  CommentModel({
    required this.id,
    required this.discussionId,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.content,
    required this.createdAt,
    this.likeCount = 0,
    this.isLiked = false,
    this.replies = const [],
    this.showReplies = false,
  });
}
