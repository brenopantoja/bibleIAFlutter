import 'package:bibliaia/core/data_base/database_service.dart';
 
class ConversationRepository {
   // Cria uma nova conversa
  Future<int> createConversation(
    String firstQuestion,
  ) async {
    final db =
        await DatabaseService.instance.database;

    return await db.insert(
      'conversation',
      {
        'title': firstQuestion,
        'createdAt':
            DateTime.now().toIso8601String(),
        'updatedAt':
            DateTime.now().toIso8601String(),
      },
    );
  }
  // Lista todas as conversas
  Future<List<Map<String, dynamic>>>
      findAll() async {
    final db =
        await DatabaseService.instance.database;

    return await db.query(
      'conversation',
      orderBy: 'updatedAt DESC',
    );
  }

  // Busca uma conversa pelo ID

  Future<Map<String, dynamic>?> findById(
    int id,
  ) async {
    final db =
        await DatabaseService.instance.database;

    final result = await db.query(
      'conversation',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  // Atualiza o título
  Future<void> updateTitle({
    required int id,
    required String title,
  }) async {
    final db =
        await DatabaseService.instance.database;

    await db.update(
      'conversation',
      {
        'title': title,
        'updatedAt':
            DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Atualiza a data da conversa
  Future<void> touch(
    int id,
  ) async {
    final db =
        await DatabaseService.instance.database;

    await db.update(
      'conversation',
      {
        'updatedAt':
            DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Exclui uma conversa
  Future<void> delete(
    int id,
  ) async {
    final db =
        await DatabaseService.instance.database;

    await db.delete(
      'conversation',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  // Remove todas as conversas
  Future<void> clear() async {
    final db =
        await DatabaseService.instance.database;

    await db.delete(
      'conversation',
    );
  }
  // Quantidade de conversas
  Future<int> count() async {
    final db =
        await DatabaseService.instance.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM conversation',
    );

    return result.isEmpty
        ? 0
        : (result.first.values.first as int);
  }

  // Existe alguma conversa?
  Future<bool> hasConversation() async {
    return await count() > 0;
  }
}