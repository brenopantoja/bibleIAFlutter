class ChatConversation {
  final int? id;

  final String title;

  final DateTime createdAt;

  ChatConversation({
    this.id,
    required this.title,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ChatConversation.fromMap(
    Map<String, dynamic> map,
  ) {
    return ChatConversation(
      id: map['id'],
      title: map['title'],
      createdAt: DateTime.parse(
        map['created_at'],
      ),
    );
  }
}