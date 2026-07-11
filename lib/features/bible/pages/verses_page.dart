import 'package:flutter/material.dart';

import '../models/bible_book.dart';

class VersesPage extends StatelessWidget {
  final BibleBook book;
  final int chapterIndex;

  const VersesPage({
    super.key,
    required this.book,
    required this.chapterIndex,
  });

  @override
  Widget build(BuildContext context) {
    final List verses = book.chapters[chapterIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${book.name} ${chapterIndex + 1}',
        ),
      ),
      body: ListView.separated(
        itemCount: verses.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(
              '${index + 1}. ${verses[index]}',
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.favorite_border,
              ),
              onPressed: () {
                // Favoritar (Sprint seguinte)
              },
            ),
          );
        },
      ),
    );
  }
}