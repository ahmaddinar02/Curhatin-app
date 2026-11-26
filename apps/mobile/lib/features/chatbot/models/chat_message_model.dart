enum ChatSender { user, bot }

class ChatMessageModel {
  final String id;
  final String text;
  final ChatSender sender;
  final DateTime timestamp;

  const ChatMessageModel({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  bool get isUser => sender == ChatSender.user;
}

class ChatSessionModel {
  final String id;
  final String title;
  final DateTime updatedAt;
  final List<ChatMessageModel> messages;

  const ChatSessionModel({
    required this.id,
    required this.title,
    required this.updatedAt,
    required this.messages,
  });

  ChatSessionModel copyWith({
    String? title,
    DateTime? updatedAt,
    List<ChatMessageModel>? messages,
  }) {
    return ChatSessionModel(
      id: id,
      title: title ?? this.title,
      updatedAt: updatedAt ?? this.updatedAt,
      messages: messages ?? this.messages,
    );
  }
}
