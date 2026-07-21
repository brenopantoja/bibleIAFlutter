import 'package:bibliaia/core/data_base/database_service.dart';

import '../models/favorite_item.dart';

class FavoriteDatasource {

  final DatabaseService _database =
      DatabaseService.instance;

  Future<int> save(
    FavoriteItem item,
  ) async {

    final db = await _database.database;

    return db.insert(
      'favorite',
      item.toMap(),
    );
  }

  Future<List<FavoriteItem>> findAll() async {

    final db = await _database.database;

    final result = await db.query(
      'favorite',
      orderBy: 'created_at DESC',
    );

    return result
        .map(FavoriteItem.fromMap)
        .toList();
  }

  Future<void> delete(
    int id,
  ) async {

    final db = await _database.database;

    await db.delete(
      'favorite',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> exists(
    FavoriteItem item,
  ) async {

    final db = await _database.database;

    final result = await db.query(
      'favorite',
      where:
          'type = ? AND title = ? AND language = ?',
      whereArgs: [
        item.type.name,
        item.title,
        item.language,
      ],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<void> deleteItem(
    FavoriteItem item,
  ) async {

    final db = await _database.database;

    await db.delete(
      'favorite',
      where:
          'type = ? AND title = ? AND language = ?',
      whereArgs: [
        item.type.name,
        item.title,
        item.language,
      ],
    );
  }

  Future<int> count() async {

    final db = await _database.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM favorite',
    );

    return result.first.values.first as int;
  }

  Future<void> clear() async {

    final db = await _database.database;

    await db.delete(
      'favorite',
    );
  }

}