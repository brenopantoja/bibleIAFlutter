class ChatRequest {

  final String message;

  final String language;

  const ChatRequest({

    required this.message,

    required this.language,

  });

  Map<String, dynamic> toJson() {

    return {

      'message': message,

      'language': language,

    };

  }

}