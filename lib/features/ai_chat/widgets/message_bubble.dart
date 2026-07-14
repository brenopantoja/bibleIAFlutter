import 'package:biblia_ia/features/ai_chat/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble
    extends StatelessWidget {

  final ChatMessage message;

  const MessageBubble({

    super.key,

    required this.message,

  });

  @override
  Widget build(BuildContext context) {

    final user =
        message.sender ==
        Sender.user;

    return Align(

      alignment: user

          ? Alignment.centerRight

          : Alignment.centerLeft,

      child: Container(

        margin:
            const EdgeInsets.all(8),

        padding:
            const EdgeInsets.all(14),

        decoration: BoxDecoration(

          color: user

              ? Colors.blue

              : Colors.grey.shade200,

          borderRadius:
              BorderRadius.circular(16),

        ),

        child: Text(

          message.text,

          style: TextStyle(

            color: user

                ? Colors.white

                : Colors.black,

          ),

        ),

      ),

    );

  }

}