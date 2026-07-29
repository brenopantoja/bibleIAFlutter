class SearchResult {
  const SearchResult({
    required this.book,
    required this.chapter,
    required this.verse,
    required this.reference,
    required this.language,
    required this.text,
  });

  final String book;
  final int chapter;
  final int verse;
  final String reference;
  final String language;
  final String text;

  factory SearchResult.fromMap(
    Map<String, dynamic> map,
  ) {
    return SearchResult(
      book: map['book'],
      chapter: map['chapter'],
      verse: map['verse'],
      reference: map['reference'],
      language: map['language'],
      text: map['text'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'book': book,
      'chapter': chapter,
      'verse': verse,
      'reference': reference,
      'language': language,
      'text': text,
    };
  }
}