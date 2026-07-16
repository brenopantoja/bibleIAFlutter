class HistoryMessage {
  final int? id;

  final int conversationId;

  final String role;

  final String content;

  final DateTime createdAt;

  const HistoryMessage({
    this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conversationId': conversationId,
      'role': role,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory HistoryMessage.fromMap(
    Map<String, dynamic> map,
  ) {
    return HistoryMessage(
      id: map['id'],
      conversationId: map['conversationId'],
      role: map['role'],
      content: map['content'],
      createdAt: DateTime.parse(
        map['createdAt'],
      ),
    );
  }
}