class SearchResult {
  final int bookIndex;

  final String book;
  final int chapter;
  final int verse;
  final String text;

  const SearchResult({
    required this.bookIndex,
    required this.book,
    required this.chapter,
    required this.verse,
    required this.text,
  });
}