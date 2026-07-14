enum Sender {
  user,
  assistant,
}

class ChatMessage {
  final String id;

  final String text;

  final Sender sender;

  final DateTime createdAt;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.sender,
    required this.createdAt,
  });

  ChatMessage copyWith({
    String? text,
  }) {
    return ChatMessage(
      id: id,
      text: text ?? this.text,
      sender: sender,
      createdAt: createdAt,
    );
  }
}