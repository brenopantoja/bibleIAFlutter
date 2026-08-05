import 'package:bibliaia/core/help/app_font.dart';
import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/core/providers/font_provider.dart';
import 'package:bibliaia/features/ai_chat/controllers/bible_reference_controller.dart';
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
                          fontSize: AppFont.body,
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
                        style: TextStyle(
                          fontSize: AppFont.body,
                          height: 1.5,
                          color: Colors.white,
                        ),
                      )
                    : MarkdownBody(
                selectable: true,
                data: BibleReferenceController.convertBibleReferences(
                  message.text,
                ),
                onTapLink: (text, href, title) async {
                  if (href != null && href.startsWith('verse://')) {
                    await BibleReferenceController.openVerse(
                      context,
                      href,
                    );
                  }
                },
                styleSheet: MarkdownStyleSheet(
                  p: TextStyle(
                    fontSize: AppFont.body,
                    height: 1.55,
                    color: Colors.black87,
                  ),
                  h1:  TextStyle(
                  fontSize: AppFont.h1,
                    fontWeight: FontWeight.bold,
                  ),
                  h2: TextStyle(
                    fontSize: AppFont.h2,
                    fontWeight: FontWeight.bold,
                  ),
                  h3: TextStyle(
                    fontSize: AppFont.h3,
                    fontWeight: FontWeight.bold,
                  ),
                  strong: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  blockquote: TextStyle(
                    fontSize: AppFont.body,
                    color: Colors.blueGrey,
                    fontStyle: FontStyle.italic,
                  ),
                  listBullet: TextStyle(
                  fontSize: AppFont.body,
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
                     ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 1),
                      content: Text(
                        isFavorite
                            ? AppStrings.favoriteAdded
                            : AppStrings.favoriteRemoved,
                          ),
                        ),
                      );
                    }
                    
                    );
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
                    fontSize: FontProvider.instance.fontSize - 5,
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
