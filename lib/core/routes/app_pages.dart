import 'package:bibliaia/features/ai_chat/pages/ai_chat_page.dart';
import 'package:bibliaia/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../../features/bible/pages/books_page.dart';

import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = <String, WidgetBuilder>{
    AppRoutes.books: (_) => const BooksPage(),
    AppRoutes.aiChat: (_) => const AiChatPage(),
    AppRoutes.home: (_) => const HomePage(),
     
  };
}