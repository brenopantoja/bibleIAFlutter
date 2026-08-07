import 'package:bibliaia/core/help/app_font.dart';
import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:bibliaia/features/ai_chat/pages/ai_chat_page.dart';
import 'package:bibliaia/features/ai_chat/repository/chart_history/conversation_repository.dart';
import 'package:bibliaia/util/date_utils.dart';
import 'package:flutter/material.dart';

class ChatHistoryPage extends StatefulWidget {
  const ChatHistoryPage({
    super.key,
  });

  @override
  State<ChatHistoryPage> createState() =>
      _ChatHistoryPageState();
}

class _ChatHistoryPageState
    extends State<ChatHistoryPage> {

  final ConversationRepository repository =
      ConversationRepository();

  late Future<List<Map<String, dynamic>>> future;

  @override
  void initState() {
    super.initState();

    future = repository.findAll();
  }

  Future<void> _reload() async {
    setState(() {
      future = repository.findAll();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
          AppStrings.history,
             style: TextStyle(
            fontSize: AppFont.h2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: FutureBuilder<List<Map<String, dynamic>>>(

        future: future,

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );

          }

          if (snapshot.hasError) {

            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(
                fontSize: AppFont.body,
                ),
              ),
            );

          }

          final conversations =
              snapshot.data ?? [];

          if (conversations.isEmpty) {

            return Center(

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.history,
                    size: AppFont.h1 + 40,
                    color: Colors.grey,
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  Text(
                     AppStrings.noHistory,
                    style: TextStyle(
                    fontSize: AppFont.title,
                    fontWeight: FontWeight.bold,
                    ),
                  ),

                ],

              ),

            );

          }

          return ListView.separated(

            itemCount: conversations.length,

            separatorBuilder: (_, __) =>
                const Divider(
              height: 1,
            ),

            itemBuilder: (context, index) {

              final item =
                  conversations[index];

              return ListTile(

                leading: CircleAvatar(

                  backgroundColor:
                      Colors.blue.shade100,

                  child: const Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.blue,
                  ),

                ),

                title: Text(

                  item['title'],

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize: AppFont.title,
                    fontWeight:
                        FontWeight.w600,
                  ),

                ),

                subtitle: Text(

                  AppDateUtils
                      .formatFromString(
                    item['createdAt'],
                  ),
                   style: TextStyle(
                  fontSize: AppFont.subtitle,
                  ),
                ),

                trailing:
                    PopupMenuButton<int>(

                  itemBuilder: (_) => [

                    PopupMenuItem<int>(
                      value: 1,
                      child: Text(
                        AppStrings.delete,
                      style: TextStyle(
                      fontSize: AppFont.body,
                        ),
                      ),
                    ),

                  ],

                  onSelected:
                      (value) async {

                    if (value == 1) {

                      await repository.delete(
                        item['id'],
                      );

                      await _reload();

                    }

                  },

                ),

                onTap: () async {

                  await Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) => AiChatPage(

                        conversationId:
                            item['id'] as int,

                      ),

                    ),

                  );

                  await _reload();

                },

              );

            },

          );

        },

      ),

    );

  }

}