import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/features/ai_chat/models/chat_message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final bool user =
        message.sender == Sender.user;

    final bool english =
        BibleProvider.instance.english;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Align(
        alignment: user
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 360,
          ),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: user
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade200,
              borderRadius:
                  BorderRadius.only(
                topLeft:
                    const Radius.circular(18),
                topRight:
                    const Radius.circular(18),
                bottomLeft:
                    Radius.circular(
                  user ? 18 : 4,
                ),
                bottomRight:
                    Radius.circular(
                  user ? 4 : 18,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Row(
                  children: [

                    CircleAvatar(
                      radius: 14,
                      backgroundColor: user
                          ? Colors.white24
                          : Colors.blue.shade100,
                      child: Icon(
                        user
                            ? Icons.person
                            : Icons.auto_awesome,
                        size: 16,
                        color: user
                            ? Colors.white
                            : Colors.blue,
                      ),
                    ),

                    const SizedBox(
                      width: 8,
                    ),

                    Expanded(
                      child: Text(
                        user
                            ? (english
                                ? 'You'
                                : 'Você')
                            : 'Bible IA',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          color: user
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),

                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                SelectableText(
                  message.text,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.55,
                    color: user
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                Align(
                  alignment:
                      Alignment.centerRight,
                  child: Text(
                    _formatTime(
                      message.createdAt,
                    ),
                    style: TextStyle(
                      fontSize: 11,
                      color: user
                          ? Colors.white70
                          : Colors.grey,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(
    DateTime date,
  ) {
    final hour =
        date.hour.toString().padLeft(2, '0');

    final minute =
        date.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }
}