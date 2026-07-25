import '../datasource/verse_remote_datasource.dart';
import '../models/verse_of_day.dart';

class VerseRepository {

  VerseRepository({
    required this.datasource,
  });

  final VerseRemoteDatasource datasource;

  Future<VerseOfDay> getVerse(
    String language,
  ) {
    return datasource.getVerse(
      language,
    );
  }
}