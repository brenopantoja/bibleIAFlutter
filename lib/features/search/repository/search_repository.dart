import '../datasource/search_remote_datasource.dart';
import '../models/search_result.dart';

class SearchRepository {
  const SearchRepository({
    this.datasource =
        const SearchRemoteDatasource(),
  });

  final SearchRemoteDatasource datasource;

  Future<List<SearchResult>> search({
    required String book,
    required int chapter,
  }) {
    return datasource.search(
      book: book,
      chapter: chapter,
    );
  }
}