import 'package:biblia_ia/features/ai_chat/controllers/ai_chat_controller.dart';
import 'package:biblia_ia/features/ai_chat/datasource/ai_remote_datasource.dart';
import 'package:biblia_ia/features/ai_chat/repository/ai_repository.dart';
import 'package:biblia_ia/features/ai_chat/widgets/input_bar.dart';
import 'package:biblia_ia/features/ai_chat/widgets/message_bubble.dart';
import 'package:biblia_ia/features/ai_chat/widgets/suggestion_card.dart';
import 'package:biblia_ia/features/ai_chat/widgets/typing_indicator.dart';
import 'package:biblia_ia/shared/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  late final AiChatController controller;

  final TextEditingController messageController =
      TextEditingController();

  final ScrollController scrollController =
      ScrollController();

  @override
  void initState() {
    super.initState();

    controller = AiChatController(
      repository: AiRepository(
        datasource: AiRemoteDatasource(),
      ),
    );

    controller.addListener(() {
      if (mounted) {
        setState(() {});
        _scrollBottom();
      }
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = messageController.text.trim();

    if (text.isEmpty) {
      return;
    }

    messageController.clear();

    await controller.send(text);
  }

  void _scrollBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasMessages = controller.messages.isNotEmpty;

    return Scaffold(
      drawer: const AppDrawer(
        version: '1.0.0',
      ),

      appBar: AppBar(
        title: const Text('Bible IA'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              controller.messages.clear();
              setState(() {});
            },
          ),
        ],
      ),

      body: Column(
        children: [

          Expanded(
            child: hasMessages
                ? ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(
                        message: controller.messages[index],
                      );
                    },
                  )
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      SuggestionCard(
                        onTap: () {
                          messageController.text =
                              'Quem foi o rei Davi?';
                        },
                      ),
                    ],
                  ),
          ),

          TypingIndicator(
            visible: controller.loading,
          ),

          InputBar(
            controller: messageController,
            sending: controller.loading,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}