class FavoriteVerse {
  final int? id;
  final String book;
  final int chapter;
  final int verse;
  final String reference;
  final String text;
  final String language;
  final DateTime createdAt;

  const FavoriteVerse({
    this.id,
    required this.book,
    required this.chapter,
    required this.verse,
    required this.reference,
    required this.text,
    required this.language,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'book': book,
      'chapter': chapter,
      'verse': verse,
      'reference': reference,
      'text': text,
      'language': language,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory FavoriteVerse.fromMap(Map<String, dynamic> map) {
    return FavoriteVerse(
      id: map['id'],
      book: map['book'],
      chapter: map['chapter'],
      verse: map['verse'],
      reference: map['reference'],
      text: map['text'],
      language: map['language'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}