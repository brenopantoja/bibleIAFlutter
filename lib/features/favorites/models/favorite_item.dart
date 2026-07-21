import 'favorite_type.dart';

class FavoriteItem {
  final int? id;

  /// Tipo do favorito
  final FavoriteType type;

  /// Título mostrado na lista
  final String title;

  /// Pequena descrição
  final String description;

  /// Conteúdo completo
  final String? text;

  /// Idioma
  final String language;

  /// Livro
  final String? book;

  /// Capítulo
  final int? chapter;

  /// Versículo
  final int? verse;

  /// Pesquisa salva
  final String? search;

  /// Data de criação
  final DateTime createdAt;

  const FavoriteItem({
    this.id,
    required this.type,
    required this.title,
    required this.description,
    this.text,
    required this.language,
    this.book,
    this.chapter,
    this.verse,
    this.search,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'description': description,
      'text': text,
      'language': language,
      'book': book,
      'chapter': chapter,
      'verse': verse,
      'search': search,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory FavoriteItem.fromMap(
    Map<String, dynamic> map,
  ) {
    return FavoriteItem(
      id: map['id'],
      type: FavoriteType.values.firstWhere(
        (e) => e.name == map['type'],
      ),
      title: map['title'],
      description: map['description'],
      text: map['text'],
      language: map['language'],
      book: map['book'],
      chapter: map['chapter'],
      verse: map['verse'],
      search: map['search'],
      createdAt: DateTime.parse(
        map['created_at'],
      ),
    );
  }

  FavoriteItem copyWith({
    int? id,
    FavoriteType? type,
    String? title,
    String? description,
    String? text,
    String? language,
    String? book,
    int? chapter,
    int? verse,
    String? search,
    DateTime? createdAt,
  }) {
    return FavoriteItem(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      text: text ?? this.text,
      language: language ?? this.language,
      book: book ?? this.book,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      search: search ?? this.search,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return '''
FavoriteItem(
  id: $id,
  type: $type,
  title: $title,
  description: $description,
  language: $language,
  book: $book,
  chapter: $chapter,
  verse: $verse,
  search: $search,
  createdAt: $createdAt
)
''';
  }
}