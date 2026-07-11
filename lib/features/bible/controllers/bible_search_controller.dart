import 'package:flutter/material.dart';

import '../../bible/models/bible_book.dart';
import '../models/search_result.dart';

class BibleSearchController extends ChangeNotifier {
  BibleSearchController(this.books);

  final List<BibleBook> books;

  final List<SearchResult> results = [];

  void search(String text) {
    results.clear();

    if (text.trim().isEmpty) {
      notifyListeners();
      return;
    }

    final query = text.toLowerCase();

    for (final book in books) {
      for (int c = 0; c < book.chapters.length; c++) {
        final chapter = book.chapters[c] as List;

        for (int v = 0; v < chapter.length; v++) {
          final verse = chapter[v].toString();

          if (verse.toLowerCase().contains(query)) {
            results.add(
              SearchResult(
                book: book.name,
                chapter: c + 1,
                verse: v + 1,
                text: verse,
              ),
            );
          }
        }
      }
    }

    notifyListeners();
  }
}