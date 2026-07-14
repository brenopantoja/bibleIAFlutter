import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../models/chat_request.dart';
import '../repository/ai_repository.dart';
import '../../../core/providers/bible_provider.dart';

class AiChatController extends ChangeNotifier {

  AiChatController({
    required this.repository,
  });

  final AiRepository repository;

  final List<ChatMessage> messages = [];

  final language =

    BibleProvider.instance.english

        ? 'EN_US'

        : 'PT_BR';
  

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
          language: language,
        ),

      );

      debugPrint(
        '=====================================',
      );

      debugPrint(
        'RESPOSTA DO BACKEND',
      );

      debugPrint(
        '''
          ${response.theme}

          ${response.reflection}
          ''',
      );

      debugPrint(
        '=====================================',
      );
          messages.add(

            ChatMessage(

              id: DateTime.now()
                  .millisecondsSinceEpoch
                  .toString(),

              text:

          '''📖 ${response.theme}

          ${response.reflection}
          ''',

              sender: Sender.assistant,

              createdAt: DateTime.now(),

            ),

          );
      /*messages.add(

        ChatMessage(

          id: DateTime.now()
              .millisecondsSinceEpoch
              .toString(),

          text: response.reflection,

          sender: Sender.assistant,

          createdAt: DateTime.now(),

        ),

      ); */

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