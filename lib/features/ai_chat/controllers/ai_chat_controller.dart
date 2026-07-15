import 'package:bibliaia/core/providers/bible_provider.dart';
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

  final ScrollController scrollController =
      ScrollController();

  bool loading = false;

  Future<void> send(
    String question,
  ) async {
    if (question.trim().isEmpty) {
      return;
    }

    final language =
        BibleProvider.instance.english
            ? 'EN_US'
            : 'PT_BR';

    // Mensagem do usuário

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

    _scrollToBottom();

    try {
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
        'Idioma: $language',
      );
      debugPrint(
        '=====================================',
      );

      final response =
          await repository.ask(
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
        'Tema: ${response.theme}',
      );
      debugPrint(
        response.reflection,
      );
      debugPrint(
        '=====================================',
      );

      messages.add(
        ChatMessage(
          id: DateTime.now()
              .millisecondsSinceEpoch
              .toString(),
          text: response.reflection,
          sender: Sender.assistant,
          createdAt: DateTime.now(),
        ),
      );
    } catch (e, s) {
      debugPrint(
        '=====================================',
      );
      debugPrint(
        'ERRO AO CHAMAR BACKEND',
      );
      debugPrint(
        e.toString(),
      );
      debugPrint(
        s.toString(),
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
              'Não foi possível consultar a IA.\n\n$e',
          sender: Sender.assistant,
          createdAt: DateTime.now(),
        ),
      );
    } finally {
      loading = false;

      notifyListeners();

      _scrollToBottom();
    }
  }

  void clearConversation() {
    messages.clear();

    notifyListeners();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (!scrollController.hasClients) {
          return;
        }

        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(
            milliseconds: 300,
          ),
          curve: Curves.easeOut,
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}