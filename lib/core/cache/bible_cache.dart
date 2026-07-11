import '../../features/bible/models/bible_book.dart';

class BibleCache {
  BibleCache._();

  static List<BibleBook> books = [];

  static bool english = false;

  static bool get loaded => books.isNotEmpty;

  static void clear() {
    books.clear();
  }
}