class VerseOfDay {
  final String book;
  final int chapter;
  final int verse;
  final String reference;
  final String language;
  final String text;

  const VerseOfDay({
    required this.book,
    required this.chapter,
    required this.verse,
    required this.reference,
    required this.language,
    required this.text,
  });

  factory VerseOfDay.fromJson(
    Map<String, dynamic> json,
  ) {
    return VerseOfDay(
      book: json['book'],
      chapter: json['chapter'],
      verse: json['verse'],
      reference: json['reference'],
      language: json['language'],
      text: json['text'],
    );
  }
}