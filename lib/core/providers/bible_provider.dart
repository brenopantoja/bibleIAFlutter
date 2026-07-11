import 'package:flutter/foundation.dart';

import '../cache/bible_cache.dart';

import '../../features/bible/models/bible_book.dart';
import '../../features/bible/repository/bible_repository.dart';
import '../../features/bible/datasource/bible_local_datasource.dart';

class BibleProvider extends ChangeNotifier {
  BibleProvider._();

  static final BibleProvider instance =
      BibleProvider._();

  final BibleRepository repository =
      BibleRepository(
    datasource: const BibleLocalDatasource(),
  );

  List<BibleBook> get books =>
      BibleCache.books;

  bool get english =>
      BibleCache.english;

  String get language =>
      BibleCache.language;

  bool get loaded =>
      BibleCache.loaded;

  Future<void> initialize() async {
    if (loaded) {
      return;
    }

    await load(
      english: false,
    );
  }

  Future<void> load({
    required bool english,
  }) async {

    final data =
        await repository.getBooks(
      english: english,
    );

    BibleCache.changeLanguage(
      data,
      english,
    );

    notifyListeners();
  }

  Future<void> changeLanguage(
    bool english,
  ) async {

    await load(
      english: english,
    );

  }

  BibleBook book(
    int index,
  ) {
    return books[index];
  }

  void refresh() {
    notifyListeners();
  }
}