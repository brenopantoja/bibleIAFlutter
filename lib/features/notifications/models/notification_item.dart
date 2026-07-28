class NotificationItem {
  const NotificationItem({
    this.id,
    required this.title,
    required this.body,
    required this.reference,
    required this.language,
    required this.book,
    required this.chapter,
    required this.verse,
    required this.createdAt,
    this.read = false,
  });

  /// ID da notificação no SQLite
  final int? id;

  /// Título exibido na notificação
  final String title;

  /// Texto do versículo
  final String body;

  /// Ex.: João 3:16
  final String reference;

  /// PT_BR | EN_US
  final String language;

  /// Nome do livro
  final String book;

  /// Capítulo
  final int chapter;

  /// Versículo
  final int verse;

  /// Data/Hora do recebimento
  final DateTime createdAt;

  /// Indica se foi lida
  final bool read;

  NotificationItem copyWith({
    int? id,
    String? title,
    String? body,
    String? reference,
    String? language,
    String? book,
    int? chapter,
    int? verse,
    DateTime? createdAt,
    bool? read,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      reference: reference ?? this.reference,
      language: language ?? this.language,
      book: book ?? this.book,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      createdAt: createdAt ?? this.createdAt,
      read: read ?? this.read,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'reference': reference,
      'language': language,
      'book': book,
      'chapter': chapter,
      'verse': verse,
      'created_at': createdAt.toIso8601String(),
      'read': read ? 1 : 0,
    };
  }

  factory NotificationItem.fromMap(
    Map<String, dynamic> map,
  ) {
    return NotificationItem(
      id: map['id'] as int?,
      title: map['title'] as String,
      body: map['body'] as String,
      reference: map['reference'] as String,
      language: map['language'] as String,
      book: map['book'] as String,
      chapter: map['chapter'] as int,
      verse: map['verse'] as int,
      createdAt: DateTime.parse(
        map['created_at'] as String,
      ),
      read: (map['read'] as int) == 1,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory NotificationItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return NotificationItem.fromMap(json);
  }

  @override
  String toString() {
    return '''
NotificationItem(
  id: $id,
  title: $title,
  body: $body,
  reference: $reference,
  language: $language,
  book: $book,
  chapter: $chapter,
  verse: $verse,
  read: $read,
  createdAt: $createdAt
)
''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is NotificationItem &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.reference == reference &&
        other.language == language &&
        other.book == book &&
        other.chapter == chapter &&
        other.verse == verse &&
        other.createdAt == createdAt &&
        other.read == read;
  }

  @override
  int get hashCode {
    return Object.hash(
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
    );
  }
}