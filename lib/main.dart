import 'package:bibliaia/core/routes/app_pages.dart';
import 'package:bibliaia/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

import 'features/splash/pages/splash_page.dart';

void main() {
  runApp(const BibleIAApp());
}

class BibleIAApp extends StatelessWidget {
  const BibleIAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bible IA',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routes: AppPages.routes,
      home: const SplashPage(),
    );
  }
}