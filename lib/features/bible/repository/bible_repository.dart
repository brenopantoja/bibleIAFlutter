import 'package:biblia_ia/features/bible/datasource/bible_local_datasource.dart';

import '../models/bible_book.dart';

class BibleRepository {
  BibleRepository({
    required this.datasource,
  });

  final BibleLocalDatasource datasource;

  Future<List<BibleBook>> getBooks({
    bool english = false,
  }) async {
    final data = english
        ? await datasource.loadEnglish()
        : await datasource.loadPortuguese();

    return data
        .map<BibleBook>(
          (e) => BibleBook.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}