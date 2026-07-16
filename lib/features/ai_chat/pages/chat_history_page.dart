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

        title: const Text(
          'Histórico',
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
              ),
            );

          }

          final conversations =
              snapshot.data ?? [];

          if (conversations.isEmpty) {

            return const Center(

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.history,
                    size: 80,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Nenhuma conversa encontrada.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),

                ],

              ),

            );

          }

          return ListView.separated(

            itemCount: conversations.length,

            separatorBuilder: (_, __) =>
                const Divider(height: 1),

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

                  style: const TextStyle(
                    fontWeight:
                        FontWeight.w600,
                  ),

                ),

                subtitle: Text(

                  AppDateUtils
                      .formatFromString(
                    item['createdAt'],
                  ),

                ),

                trailing: PopupMenuButton(

                  itemBuilder: (_) => [

                    const PopupMenuItem(

                      value: 1,

                      child: Text(
                        'Excluir',
                      ),

                    ),

                  ],

                  onSelected: (value) async {

                    if (value == 1) {

                      await repository.delete(
                        item['id'],
                      );

                      _reload();

                    }

                  },

                ),

                onTap: () {

                  Navigator.pop(
                    context,
                    item['id'],
                  );

                },

              );

            },

          );

        },

      ),

    );

  }

}