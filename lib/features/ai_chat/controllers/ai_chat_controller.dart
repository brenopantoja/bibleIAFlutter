import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/features/ai_chat/repository/chart_history/conversation_repository.dart';
import 'package:bibliaia/features/ai_chat/repository/chart_history/message_repository.dart';
import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../models/chat_request.dart';
import '../repository/ai_repository.dart';

class AiChatController extends ChangeNotifier {
  AiChatController({
    required this.repository,
  });

  final AiRepository repository;

  final ConversationRepository conversationRepository =
      ConversationRepository();

  final MessageRepository messageRepository =
      MessageRepository();

  final List<ChatMessage> messages = [];

  final ScrollController scrollController =
      ScrollController();

  bool loading = false;

  int? conversationId;

  Future<void> send(
    String question,
  ) async {

    if (question.trim().isEmpty) {
      return;
    }

    conversationId ??= await conversationRepository.createConversation(
        question,
      );

    final language =
        BibleProvider.instance.english
            ? 'EN_US'
            : 'PT_BR';


    // Mensagem do usuário
    final userMessage = ChatMessage(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),
      text: question,
      sender: Sender.user,
      createdAt: DateTime.now(),
    );

    messages.add(userMessage);

    await messageRepository.saveMessage(
      conversationId: conversationId!,
      role: 'user',
      content: question,
    );

    await conversationRepository.touch(
      conversationId!,
    );

    loading = true;

    notifyListeners();

    _scrollToBottom();

    try {

      debugPrint(
          '=====================================');
      debugPrint('ENVIANDO PARA O BACKEND');
      debugPrint(question);
      debugPrint('Idioma: $language');
      debugPrint(
          '=====================================');

// Monta o contexto da conversa
  final history =
      await messageRepository.findByConversation(
    conversationId!,
  );

  final buffer = StringBuffer();

  if (history.isNotEmpty) {

    buffer.writeln(
        '=========================================');

    buffer.writeln(
        'HISTÓRICO DA CONVERSA');

    buffer.writeln();

    for (final item in history) {

      if (item.role == 'user') {

        buffer.writeln('Usuário:');

      } else {

        buffer.writeln('Bible IA:');

      }

      buffer.writeln(item.content);

      buffer.writeln();

    }

    buffer.writeln(
        '=========================================');

    buffer.writeln();

  }

  buffer.writeln(
      'PERGUNTA ATUAL');

  buffer.writeln();

  buffer.writeln(question);

  buffer.writeln();

  buffer.writeln(
      '=========================================');

  buffer.writeln(
      'Utilize o histórico apenas como contexto.');

  buffer.writeln(
      'Responda somente à pergunta atual.');

  buffer.writeln(
      'Caso o histórico não seja relevante, ignore-o.');

  final prompt =
      buffer.toString();

  final response =
      await repository.ask(
    ChatRequest(
      message: prompt,
      language: language,
    ),
  );

// Resposta da IA

      final assistantMessage =
          ChatMessage(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        text: response.reflection,
        sender: Sender.assistant,
        createdAt: DateTime.now(),
      );

      messages.add(
        assistantMessage,
      );

      await messageRepository.saveMessage(
        conversationId:
            conversationId!,
        role: 'assistant',
        content:
            response.reflection,
      );

      await conversationRepository.touch(
        conversationId!,
      );

    } catch (e, s) {

      debugPrint(
          '=====================================');
      debugPrint(
          'ERRO AO CHAMAR BACKEND');
      debugPrint(e.toString());
      debugPrint(s.toString());
      debugPrint(
          '=====================================');

      final error =
          'Não foi possível consultar a IA.\n\n$e';

      messages.add(
        ChatMessage(
          id: DateTime.now()
              .millisecondsSinceEpoch
              .toString(),
          text: error,
          sender:
              Sender.assistant,
          createdAt:
              DateTime.now(),
        ),
      );

      await messageRepository.saveMessage(
        conversationId:
            conversationId!,
        role: 'assistant',
        content: error,
      );

      await conversationRepository.touch(
        conversationId!,
      );

    } finally {

      loading = false;

      notifyListeners();

      _scrollToBottom();

    }
  }

  void clearConversation() {

    conversationId = null;

    messages.clear();

    notifyListeners();

  }

  void _scrollToBottom() {

    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      if (!scrollController.hasClients) {
        return;
      }

      scrollController.animateTo(
        scrollController.position
            .maxScrollExtent,
        duration:
            const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeOut,
      );

    });

  }

  @override
  void dispose() {

    scrollController.dispose();

    super.dispose();

  }
  Future<void> loadConversation(
  int id,
) async {

  // Define conversa atual
  conversationId = id;
  // Limpa a tela
  messages.clear();
  // Busca histórico
  final history =

      await messageRepository
          .findByConversation(id);

  // Converte HistoryMessage
  // em ChatMessage da tela

  for (final item in history) {

    messages.add(

      ChatMessage(

        id: item.id.toString(),

        text: item.content,

        sender:

            item.role == 'user'

                ? Sender.user

                : Sender.assistant,

        createdAt: item.createdAt,

      ),

    );

  }

  notifyListeners();

  _scrollToBottom();

}
}