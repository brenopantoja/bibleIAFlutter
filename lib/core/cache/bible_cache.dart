import '../../features/bible/models/bible_book.dart';

class BibleCache {
  BibleCache._();

  static List<BibleBook> books = [];

  static bool english = false;

  static String get language =>
      english ? 'en' : 'pt';

  static bool get loaded =>
      books.isNotEmpty;

  static void changeLanguage(
    List<BibleBook> newBooks,
    bool isEnglish,
  ) {
    books = newBooks;
    english = isEnglish;
  }

  static void clear() {
    books.clear();
    english = false;
  }
}