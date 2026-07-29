class SearchParserResult {
  const SearchParserResult({
    required this.book,
    required this.chapter,
    this.verse,
  });

  final String book;

  final int chapter;

  final int? verse;
}

class SearchParser {
  SearchParser._();

  static SearchParserResult parse(
    String text,
  ) {
    final regex = RegExp(
      r'^(.+?)\s+(\d+)(?::(\d+))?$',
    );

    final match = regex.firstMatch(
      text.trim(),
    );

    if (match == null) {
      throw Exception(
        'Referência inválida.',
      );
    }

    return SearchParserResult(
      book: match.group(1)!.trim(),
      chapter: int.parse(match.group(2)!),
      verse:
          match.group(3) != null
              ? int.parse(match.group(3)!)
              : null,
    );
  }
}