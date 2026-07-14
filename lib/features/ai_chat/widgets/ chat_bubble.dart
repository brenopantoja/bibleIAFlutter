// ignore: file_names
import 'package:flutter/material.dart';

import '../models/chat_message.dart';

class ChatBubble extends StatelessWidget {

  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {

    final user =
        message.sender == Sender.user;

    return Align(

      alignment: user

          ? Alignment.centerRight

          : Alignment.centerLeft,

      child: Container(

        margin: const EdgeInsets.symmetric(
          vertical: 6,
        ),

        padding: const EdgeInsets.all(14),

        constraints: const BoxConstraints(
          maxWidth: 320,
        ),

        decoration: BoxDecoration(

          color: user

              ? Colors.blue

              : Colors.grey.shade200,

          borderRadius: BorderRadius.circular(18),

        ),

        child: Column(

          crossAxisAlignment:

              user

                  ? CrossAxisAlignment.end

                  : CrossAxisAlignment.start,

          children: [

            Text(

              user

                  ? 'Você'

                  : 'Bible IA',

              style: TextStyle(

                fontWeight: FontWeight.bold,

                color: user

                    ? Colors.white

                    : Colors.black,

              ),

            ),

            const SizedBox(height: 6),

            Text(

              message.text,

              style: TextStyle(

                color: user

                    ? Colors.white

                    : Colors.black87,

                fontSize: 15,

              ),

            ),
          ],
        ),
      ),
    );
  }
}