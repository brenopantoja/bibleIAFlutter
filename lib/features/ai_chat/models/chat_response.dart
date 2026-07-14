class ChatResponse {

  final String theme;

  final String reflection;

  final List<dynamic> references;

  const ChatResponse({

    required this.theme,

    required this.reflection,

    required this.references,

  });

  factory ChatResponse.fromJson(
    Map<String, dynamic> json,
  ) {

    return ChatResponse(

      theme: json['theme'] ?? '',

      reflection: json['reflection'] ?? '',

      references: json['references'] ?? [],

    );

  }

}