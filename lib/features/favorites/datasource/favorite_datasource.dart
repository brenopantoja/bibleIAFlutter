import 'package:bibliaia/core/data_base/database_service.dart';
import '../models/favorite_verse.dart';

class FavoriteDatasource {

  final DatabaseService _database =
      DatabaseService.instance;

  Future<int> save(
    FavoriteVerse verse,
  ) async {

    final db = await _database.database;

    return db.insert(
      'favorite_verse',
      verse.toMap(),
    );
  }

  Future<List<FavoriteVerse>> findAll() async {

    final db = await _database.database;

    final result = await db.query(
      'favorite_verse',
      orderBy: 'created_at DESC',
    );

    return result
        .map(FavoriteVerse.fromMap)
        .toList();
  }

  Future<void> delete(
    int id,
  ) async {

    final db = await _database.database;

    await db.delete(
      'favorite_verse',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> exists(
    String reference,
  ) async {

    final db = await _database.database;

    final result = await db.query(
      'favorite_verse',
      where: 'reference = ?',
      whereArgs: [reference],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<void> deleteByReference(
    String reference,
  ) async {

    final db = await _database.database;

    await db.delete(
      'favorite_verse',
      where: 'reference = ?',
      whereArgs: [reference],
    );
  }

  Future<int> count() async {

    final db = await _database.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM favorite_verse',
    );

    return result.first.values.first as int;
  }

  Future<void> clear() async {

    final db = await _database.database;

    await db.delete(
      'favorite_verse',
    );
  }
}