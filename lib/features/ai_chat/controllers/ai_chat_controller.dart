import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../models/chat_request.dart';
import '../repository/ai_repository.dart';

class AiChatController extends ChangeNotifier {

  AiChatController({
    required this.repository,
  });

  final AiRepository repository;

  final List<ChatMessage> messages = [];

  bool loading = false;

  Future<void> send(
    String question,
  ) async {

    if (question.trim().isEmpty) {
      return;
    }

    messages.add(

      ChatMessage(

        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),

        text: question,

        sender: Sender.user,

        createdAt: DateTime.now(),

      ),

    );

    loading = true;

    notifyListeners();

    debugPrint(
      '=====================================',
    );

    debugPrint(
      'ENVIANDO PARA O BACKEND',
    );

    debugPrint(
      question,
    );

    debugPrint(
      '=====================================',
    );

    try {

      final response = await repository.ask(

        ChatRequest(
          message: question,
        ),

      );

      debugPrint(
        '=====================================',
      );

      debugPrint(
        'RESPOSTA DO BACKEND',
      );

      debugPrint(
        response.answer,
      );

      debugPrint(
        '=====================================',
      );

      messages.add(

        ChatMessage(

          id: DateTime.now()
              .millisecondsSinceEpoch
              .toString(),

          text: response.answer,

          sender: Sender.assistant,

          createdAt: DateTime.now(),

        ),

      );

    } catch (e) {

      debugPrint(
        'ERRO AO CHAMAR BACKEND',
      );

      debugPrint(
        e.toString(),
      );

      messages.add(

        ChatMessage(

          id: DateTime.now()
              .millisecondsSinceEpoch
              .toString(),

          text: e.toString(),

          sender: Sender.assistant,

          createdAt: DateTime.now(),

        ),

      );

    } finally {

      loading = false;

      notifyListeners();
    }
  }
}