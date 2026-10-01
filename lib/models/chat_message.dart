enum ChatMessageRole { user, assistant }

class ChatMessage {
  final ChatMessageRole role;
  final String text;
  final DateTime createdAt;

  const ChatMessage({
    required this.role,
    required this.text,
    required this.createdAt,
  });

  bool get isUser => role == ChatMessageRole.user;
}
