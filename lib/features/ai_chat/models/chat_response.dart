class ChatResponse {
  final String answer;

  const ChatResponse({
    required this.answer,
  });

  factory ChatResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return ChatResponse(
      answer: json['answer'] ?? '',
    );
  }

  bool get isEmpty => answer.trim().isEmpty;
}