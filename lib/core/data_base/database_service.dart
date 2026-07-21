import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance =
      DatabaseService._();

  static Database? _database;

  // Configuração do banco
  static const String databaseName =
      'bible_ia.db';

  static const int databaseVersion = 1;

  // Retorna a instância do banco
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _openDatabase();

    return _database!;
  }
  // Abre o banco
  Future<Database> _openDatabase() async {
    final path = join(
      await getDatabasesPath(),
      databaseName,
    );

    return openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: _onOpen,
    );
  }

  // Criação inicial do banco
  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    await _createConversationTable(db);

    await _createMessageTable(db);
    
    await _createFavoriteTable(db);

  }

  // Migrações futuras
  Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    // Futuras versões do banco

    if (oldVersion < 2) {
      // Exemplo:
      // await db.execute('ALTER TABLE ...');
    }
  }

  // Banco aberto
  Future<void> _onOpen(
    Database db,
  ) async {
    await db.execute(
      'PRAGMA foreign_keys = ON',
    );
  }

  // Fecha o banco
  Future<void> close() async {
    if (_database == null) {
      return;
    }

    await _database!.close();

    _database = null;
  }

  // Remove o banco
  Future<void> deleteDatabaseFile() async {
    await close();

    final path = join(
      await getDatabasesPath(),
      databaseName,
    );

    await deleteDatabase(path);
  }

  // Limpa uma tabela
  Future<void> clearTable(
    String table,
  ) async {
    final db = await database;

    await db.delete(table);
  }

  // Conta registros
  Future<int> count(
    String table,
  ) async {
    final db = await database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM $table',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  // Existe registro?
  Future<bool> exists(
    String table,
  ) async {
    return await count(table) > 0;
  }

  // SQL Livre
  Future<List<Map<String, Object?>>> rawQuery(
    String sql, [
    List<Object?>? arguments,
  ]) async {
    final db = await database;

    return db.rawQuery(
      sql,
      arguments,
    );
  }

  Future<int> rawInsert(
    String sql, [
    List<Object?>? arguments,
  ]) async {
    final db = await database;

    return db.rawInsert(
      sql,
      arguments,
    );
  }

  Future<int> rawUpdate(
    String sql, [
    List<Object?>? arguments,
  ]) async {
    final db = await database;

    return db.rawUpdate(
      sql,
      arguments,
    );
  }

  Future<int> rawDelete(
    String sql, [
    List<Object?>? arguments,
  ]) async {
    final db = await database;

    return db.rawDelete(
      sql,
      arguments,
    );
  }

  Future<void> execute(
    String sql,
  ) async {
    final db = await database;

    await db.execute(sql);
  }

  // Conversation
  Future<void> _createConversationTable(
    Database db,
  ) async {
    await db.execute('''
CREATE TABLE conversation (

  id INTEGER PRIMARY KEY AUTOINCREMENT,

  title TEXT NOT NULL,

  createdAt TEXT NOT NULL,

  updatedAt TEXT NOT NULL

)
''');
  }

  // Message
  Future<void> _createMessageTable(
    Database db,
  ) async {
    await db.execute('''
CREATE TABLE message (

  id INTEGER PRIMARY KEY AUTOINCREMENT,

  conversationId INTEGER NOT NULL,

  role TEXT NOT NULL,

  content TEXT NOT NULL,

  createdAt TEXT NOT NULL,

  FOREIGN KEY(conversationId)
    REFERENCES conversation(id)
    ON DELETE CASCADE

)
''');
  }
  Future<void> _createFavoriteTable(
  Database db,
) async {

  await db.execute('''
CREATE TABLE favorite_verse (

  id INTEGER PRIMARY KEY AUTOINCREMENT,

  book TEXT NOT NULL,

  chapter INTEGER NOT NULL,

  verse INTEGER NOT NULL,

  reference TEXT NOT NULL,

  text TEXT NOT NULL,

  language TEXT NOT NULL,

  created_at TEXT NOT NULL

)
''');
}
}