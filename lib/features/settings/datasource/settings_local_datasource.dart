import 'package:bibliaia/core/data_base/database_service.dart';
import 'package:sqflite/sqflite.dart';

import '../models/settings.dart';

class SettingsLocalDatasource {
  const SettingsLocalDatasource();

  Future<Settings?> getSettings() async {
    final Database db =
        await DatabaseService.instance.database;

    final result = await db.query(
      'settings',
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return Settings.fromMap(result.first);
  }

  Future<void> save(
    Settings settings,
  ) async {
    final Database db =
        await DatabaseService.instance.database;

    await db.insert(
      'settings',
      settings.toMap(),
      conflictAlgorithm:
          ConflictAlgorithm.replace,
    );
  }

  Future<void> update(
    Settings settings,
  ) async {
    final Database db =
        await DatabaseService.instance.database;

    await db.update(
      'settings',
      settings.toMap(),
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  Future<void> saveOrUpdate(
    Settings settings,
  ) async {
    final current = await getSettings();

    if (current == null) {
      final map = settings.toMap();
      map['id'] = 1;

      final Database db =
          await DatabaseService.instance.database;

      await db.insert(
        'settings',
        map,
        conflictAlgorithm:
            ConflictAlgorithm.replace,
      );

      return;
    }

    await update(settings);
  }

  Future<void> delete() async {
    final Database db =
        await DatabaseService.instance.database;

    await db.delete(
      'settings',
    );
  }

  Future<void> reset() async {
    await saveOrUpdate(
      const Settings(),
    );
  }
}