class DiscussionModel {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String content;
  final String? imageUrl;
  final String category;
  final DateTime createdAt;
  int likeCount;
  int commentCount;
  bool isLiked;

  DiscussionModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.content,
    this.imageUrl,
    required this.category,
    required this.createdAt,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isLiked = false,
  });

  DiscussionModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userAvatar,
    String? content,
    String? imageUrl,
    String? category,
    DateTime? createdAt,
    int? likeCount,
    int? commentCount,
    bool? isLiked,
  }) {
    return DiscussionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
