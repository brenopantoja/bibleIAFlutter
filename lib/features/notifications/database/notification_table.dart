class NotificationTable {
  NotificationTable._();

  /// Nome da tabela
  static const String table = 'notification';

  /// Colunas
  static const String id = 'id';

  static const String title = 'title';

  static const String body = 'body';

  /// Ex.: João 3:16
  static const String reference = 'reference';

  /// PT_BR | EN_US
  static const String language = 'language';

  /// Livro
  static const String book = 'book';

  /// Capítulo
  static const String chapter = 'chapter';

  /// Versículo
  static const String verse = 'verse';

  /// Data/Hora
  static const String createdAt = 'created_at';

  /// 0 = Não lida
  /// 1 = Lida
  static const String read = 'read';

  /// Lista de colunas
  static const List<String> columns = [
    id,
    title,
    body,
    reference,
    language,
    book,
    chapter,
    verse,
    createdAt,
    read,
  ];

  /// SQL de criação
  static const String createTable = '''
CREATE TABLE $table (

  $id INTEGER PRIMARY KEY AUTOINCREMENT,

  $title TEXT NOT NULL,

  $body TEXT NOT NULL,

  $reference TEXT NOT NULL,

  $language TEXT NOT NULL,

  $book TEXT NOT NULL,

  $chapter INTEGER NOT NULL,

  $verse INTEGER NOT NULL,

  $createdAt TEXT NOT NULL,

  $read INTEGER NOT NULL DEFAULT 0

)
''';
}