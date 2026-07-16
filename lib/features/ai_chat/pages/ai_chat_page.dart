import 'package:flutter/material.dart';

import '../../../core/providers/bible_provider.dart';
import '../../../shared/widgets/app_drawer.dart';

import '../controllers/ai_chat_controller.dart';
import '../datasource/ai_remote_datasource.dart';
import '../repository/ai_repository.dart';

import '../widgets/input_bar.dart';
import '../widgets/message_list.dart';
import '../widgets/suggestion_card.dart';
import '../widgets/typing_indicator.dart';

class AiChatPage extends StatefulWidget {
  final int? conversationId;

  const AiChatPage({
    super.key,
    this.conversationId,
  });

  @override
  State<AiChatPage> createState() =>
      _AiChatPageState();
}

class _AiChatPageState
    extends State<AiChatPage> {

  late final AiChatController controller;

  final TextEditingController
      messageController =
          TextEditingController();

  @override
  void initState() {
    super.initState();

    controller = AiChatController(
      repository: AiRepository(
        datasource: AiRemoteDatasource(),
      ),
    );

    controller.addListener(_refresh);

    BibleProvider.instance
        .addListener(_refresh);

    WidgetsBinding.instance
        .addPostFrameCallback((_) async {

      if (widget.conversationId != null) {

        await controller.loadConversation(
          widget.conversationId!,
        );

      }

    });
  }

  void _refresh() {

    if (!mounted) {
      return;
    }

    setState(() {});

  }

  @override
  void dispose() {

    controller.removeListener(
      _refresh,
    );

    BibleProvider.instance
        .removeListener(
      _refresh,
    );

    controller.dispose();

    messageController.dispose();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final english =
        BibleProvider.instance.english;

    return Scaffold(

      drawer: const AppDrawer(
        version: '1.0.0',
      ),

      appBar: AppBar(

        title: Text(

          widget.conversationId == null

              ? 'Bible IA'

              : 'Conversa',

        ),

        actions: [

          IconButton(

            tooltip: english

                ? 'Clear conversation'

                : 'Limpar conversa',

            icon: const Icon(
              Icons.delete_outline,
            ),

            onPressed: () {

              controller.clearConversation();

            },

          ),

        ],

      ),

      body: Column(

        children: [

          Expanded(

            child: controller.messages.isEmpty

                ? ListView(

                    padding:
                        const EdgeInsets.all(
                      16,
                    ),

                    children: [

                      SuggestionCard(

                        onTap: (
                          question,
                        ) async {

                          await controller
                              .send(
                            question,
                          );

                        },

                      ),

                    ],

                  )

                : MessageList(

                    controller: controller
                        .scrollController,

                    messages:
                        controller.messages,

                  ),

          ),

          TypingIndicator(

            visible: controller.loading,

            message: english

                ? 'Bible IA is typing...'

                : 'Bible IA está digitando...',

          ),

          InputBar(

            controller:
                messageController,

            sending:
                controller.loading,

            hintText: english

                ? 'Ask your question...'

                : 'Digite sua pergunta...',

            onSend: () async {

              final text =
                  messageController.text
                      .trim();

              if (text.isEmpty) {
                return;
              }

              messageController.clear();

              await controller.send(
                text,
              );

            },

          ),

        ],

      ),

    );

  }

}