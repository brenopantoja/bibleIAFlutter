import 'package:bibliaia/core/data_base/database_service.dart';
import 'package:sqflite/sqflite.dart';

import '../database/notification_table.dart';
import '../models/notification_item.dart';

class NotificationLocalDatasource {
  NotificationLocalDatasource._();

  static final NotificationLocalDatasource instance =
      NotificationLocalDatasource._();

  Future<Database> get _db async =>
      DatabaseService.instance.database;

  /// Salva uma notificação
  Future<int> save(
    NotificationItem item,
  ) async {
    final db = await _db;

    return db.insert(
      NotificationTable.table,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Lista todas as notificações
  Future<List<NotificationItem>> findAll() async {
    final db = await _db;

    final result = await db.query(
      NotificationTable.table,
      columns: NotificationTable.columns,
      orderBy:
          '${NotificationTable.createdAt} DESC',
    );

    return result
        .map(NotificationItem.fromMap)
        .toList();
  }

  /// Apenas notificações não lidas
  Future<List<NotificationItem>> findUnread() async {
    final db = await _db;

    final result = await db.query(
      NotificationTable.table,
      columns: NotificationTable.columns,
      where:
          '${NotificationTable.read} = ?',
      whereArgs: const [0],
      orderBy:
          '${NotificationTable.createdAt} DESC',
    );

    return result
        .map(NotificationItem.fromMap)
        .toList();
  }

  /// Busca por ID
  Future<NotificationItem?> findById(
    int id,
  ) async {
    final db = await _db;

    final result = await db.query(
      NotificationTable.table,
      columns: NotificationTable.columns,
      where:
          '${NotificationTable.id} = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return NotificationItem.fromMap(
      result.first,
    );
  }

  /// Última notificação recebida
  Future<NotificationItem?> latest() async {
    final db = await _db;

    final result = await db.query(
      NotificationTable.table,
      columns: NotificationTable.columns,
      orderBy:
          '${NotificationTable.createdAt} DESC',
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return NotificationItem.fromMap(
      result.first,
    );
  }

  /// Quantidade de notificações não lidas
  Future<int> countUnread() async {
    final db = await _db;

    final result = await db.rawQuery(
      '''
  SELECT COUNT(*)
  FROM ${NotificationTable.table}
  WHERE ${NotificationTable.read} = 0
  ''',
      );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Existe alguma notificação?
  Future<bool> exists() async {
    final db = await _db;

    final result = await db.rawQuery(
      '''
  SELECT COUNT(*)
  FROM ${NotificationTable.table}
  ''',
      );

    return (Sqflite.firstIntValue(result) ?? 0) >
        0;
  }

  /// Marca uma notificação como lida
  Future<void> markAsRead(
    int id,
  ) async {
    final db = await _db;

    await db.update(
      NotificationTable.table,
      {
        NotificationTable.read: 1,
      },
      where:
          '${NotificationTable.id} = ?',
      whereArgs: [id],
    );
  }

  /// Marca todas como lidas
  Future<void> markAllAsRead() async {
    final db = await _db;

    await db.update(
      NotificationTable.table,
      {
        NotificationTable.read: 1,
      },
    );
  }

  /// Remove uma notificação
  Future<void> delete(
    int id,
  ) async {
    final db = await _db;

    await db.delete(
      NotificationTable.table,
      where:
          '${NotificationTable.id} = ?',
      whereArgs: [id],
    );
  }

  /// Remove todas as notificações
  Future<void> deleteAll() async {
    final db = await _db;

    await db.delete(
      NotificationTable.table,
    );
  }

  /// Verifica se a última notificação é o mesmo versículo
Future<bool> isLatestVerse(
  NotificationItem item,
) async {
    final latestItem = await latest();

    if (latestItem == null) {
      return false;
    }

    return latestItem.language == item.language &&
        latestItem.book == item.book &&
        latestItem.chapter == item.chapter &&
        latestItem.verse == item.verse;
  }
}