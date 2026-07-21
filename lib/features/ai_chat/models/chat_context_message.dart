class ChatContextMessage {

  final String role;

  final String content;

  const ChatContextMessage({

    required this.role,

    required this.content,

  });

  Map<String, dynamic> toJson() {

    return {

      'role': role,

      'content': content,

    };

  }

}