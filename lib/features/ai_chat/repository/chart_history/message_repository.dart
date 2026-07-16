import 'package:bibliaia/core/data_base/database_service.dart';
import 'package:bibliaia/features/ai_chat/models/chat_history/history_message.dart';
 
class MessageRepository {
 
  // Salva uma mensagem
  Future<int> saveMessage({
    required int conversationId,
    required String role,
    required String content,
  }) async {
    final db =
        await DatabaseService.instance.database;

    return await db.insert(
      'message',
      {
        'conversationId': conversationId,
        'role': role,
        'content': content,
        'createdAt':
            DateTime.now().toIso8601String(),
      },
    );
  }

  // Retorna todas as mensagens
  // de uma conversa
 Future<List<HistoryMessage>> findByConversation(
  int conversationId,
) async {

  final db =
      await DatabaseService.instance.database;

  final result = await db.query(

    'message',

    where: 'conversationId = ?',

    whereArgs: [conversationId],

    orderBy: 'id ASC',

  );

  return result

      .map(
        (e) => HistoryMessage.fromMap(e),
      )

      .toList();
}

  // Quantidade de mensagens
  Future<int> count(
    int conversationId,
  ) async {
    final db =
        await DatabaseService.instance.database;

    final result = await db.rawQuery(
      '''
SELECT COUNT(*)
FROM message
WHERE conversationId = ?
''',
      [conversationId],
    );

    return result.isEmpty
        ? 0
        : (result.first.values.first as int);
  }

  // Exclui uma mensagem
  Future<void> delete(
    int id,
  ) async {
    final db =
        await DatabaseService.instance.database;

    await db.delete(
      'message',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Exclui todas as mensagens
  // de uma conversa
  Future<void> deleteConversationMessages(
    int conversationId,
  ) async {
    final db =
        await DatabaseService.instance.database;

    await db.delete(
      'message',
      where: 'conversationId = ?',
      whereArgs: [conversationId],
    );
  }
  // Limpa toda a tabela
  Future<void> clear() async {
    final db =
        await DatabaseService.instance.database;

    await db.delete(
      'message',
    );
  }
}