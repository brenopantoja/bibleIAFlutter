import 'package:flutter/material.dart';

import '../models/bible_book.dart';
import 'verses_page.dart';

class ChapterPage extends StatelessWidget {
  final BibleBook book;

  const ChapterPage({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
      ),
      body: ListView.builder(
        itemCount: book.chapters.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: const Icon(Icons.menu_book),
            title: Text(
              'Capítulo ${index + 1}',
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VersesPage(
                    book: book,
                    chapterIndex: index,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}