import 'package:flutter/material.dart';

import '../../features/bible/pages/books_page.dart';
import '../../features/bible/pages/chapter_page.dart';
import '../../features/bible/pages/verses_page.dart';

import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = <String, WidgetBuilder>{
    AppRoutes.books: (_) => const BooksPage(),
    //AppRoutes.chapters: (_) => const ChapterPage(),
    //AppRoutes.verses: (_) => const VersesPage(),
  };
}