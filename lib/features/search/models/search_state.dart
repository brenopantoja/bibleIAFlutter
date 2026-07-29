import 'search_result.dart';

class SearchState {
  const SearchState({
    this.loading = false,
    this.error,
    this.book,
    this.chapter,
    this.selectedVerse,
    this.results = const [],
  });

  final bool loading;

  final String? error;

  final String? book;

  final int? chapter;

  final int? selectedVerse;

  final List<SearchResult> results;

  SearchState copyWith({
    bool? loading,
    String? error,
    String? book,
    int? chapter,
    int? selectedVerse,
    List<SearchResult>? results,
  }) {
    return SearchState(
      loading: loading ?? this.loading,
      error: error,
      book: book ?? this.book,
      chapter: chapter ?? this.chapter,
      selectedVerse:
          selectedVerse ?? this.selectedVerse,
      results: results ?? this.results,
    );
  }
}