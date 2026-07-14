class ChatRequest {

  final String message;

  const ChatRequest({
    required this.message,
  });

  Map<String,dynamic> toJson() {

    return {
      'message': message,
    };

  }

}