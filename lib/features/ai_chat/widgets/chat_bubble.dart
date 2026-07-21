import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/features/favorites/models/favorite_item.dart';
import 'package:bibliaia/features/favorites/models/favorite_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:share_plus/share_plus.dart';

import '../../favorites/repository/favorite_repository.dart';
import '../models/chat_message.dart';

class ChatBubble extends StatefulWidget {
  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    final message = widget.message;
    final bool user = message.sender == Sender.user;
    final bool english = BibleProvider.instance.english;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Align(
        alignment:
            user ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 340,
          ),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: user
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(user ? 18 : 4),
                bottomRight: Radius.circular(user ? 4 : 18),
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
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        user
                            ? (english ? 'You' : 'Você')
                            : 'Bible IA',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: user
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                user
                    ? SelectableText(
                        message.text,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: Colors.white,
                        ),
                      )
                    : MarkdownBody(
                        selectable: true,
                        data: message.text,
                        styleSheet: MarkdownStyleSheet(
                          p: const TextStyle(
                            fontSize: 15,
                            height: 1.55,
                            color: Colors.black87,
                          ),
                          h1: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          h2: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          h3: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          strong: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          blockquote: const TextStyle(
                            color: Colors.blueGrey,
                            fontStyle: FontStyle.italic,
                          ),
                          listBullet: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),

                if (!user) ...[
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      IconButton(
                    tooltip: english ? 'Favorite' : 'Favoritar',
                    icon: Icon(
                      favorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  onPressed: () async {
                try {
                  final repository = FavoriteRepository();

                  final lines = message.text.split('\n');

                  final title = lines.first.trim().isEmpty
                      ? (english ? 'AI Answer' : 'Resposta da IA')
                      : lines.first.trim();

                  final item = FavoriteItem(
                    type: FavoriteType.ai,
                    title: title,
                    description: message.text.length > 120
                        ? '${message.text.substring(0, 120)}...'
                        : message.text,
                    text: message.text,
                    language: english ? 'en' : 'pt',
                    createdAt: DateTime.now(),
                  );

                  await repository.toggleFavorite(item);

                  final isFavorite =
                      await repository.isFavorite(item);

                  if (mounted) {
                    setState(() {
                      favorite = isFavorite;
                    });
                  }
                } catch (e, s) {
                  debugPrint(e.toString());
                  debugPrint(s.toString());
                }
                },
                  ),

                      IconButton(
                        tooltip: english
                            ? 'Share'
                            : 'Compartilhar',
                        icon: const Icon(
                          Icons.share,
                        ),
                        onPressed: () async {
                          await Share.share(
                            message.text,
                          );
                        },
                      ),

                      IconButton(
                        tooltip: english
                            ? 'Copy'
                            : 'Copiar',
                        icon: const Icon(
                          Icons.copy,
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(
                              text: message.text,
                            ),
                          );

                          if (context.mounted) {
                            ScaffoldMessenger.of(
                                    context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  english
                                      ? 'Copied to clipboard.'
                                      : 'Texto copiado.',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
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
