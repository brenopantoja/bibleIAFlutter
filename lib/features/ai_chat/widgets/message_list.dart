import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import 'chat_bubble.dart';

class MessageList extends StatelessWidget {
  final List<ChatMessage> messages;

  final ScrollController controller;

  const MessageList({
    super.key,
    required this.messages,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        24,
      ),
      itemCount: messages.length,
      itemBuilder: (
        context,
        index,
      ) {
        return ChatBubble(
          message: messages[index],
        );
      },
    );
  }
}