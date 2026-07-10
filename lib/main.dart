import 'package:flutter/material.dart';

import 'features/home/pages/home_page.dart';

void main() {
  runApp(const BibleIAApp());
}

class BibleIAApp extends StatelessWidget {
  const BibleIAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bible IA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const HomePage(),
    );
  }
}