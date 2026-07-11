import 'package:biblia_ia/core/providers/bible_provider.dart';
import 'package:flutter/material.dart';

import 'chapter_page.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({
    super.key,
  });

  @override
  State<BooksPage> createState() =>
      _BooksPageState();
}

class _BooksPageState
    extends State<BooksPage> {

  @override
  void initState() {
    super.initState();

    BibleProvider.instance.addListener(
      _reload,
    );
  }

  void _reload() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {

    BibleProvider.instance.removeListener(
      _reload,
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final books =
        BibleProvider.instance.books;

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Livros da Bíblia',
        ),
      ),

      body: ListView.separated(

        itemCount: books.length,

        separatorBuilder: (_, __) =>
            const Divider(height: 1),

        itemBuilder: (_, index) {

          final book = books[index];

          return ListTile(

            leading: CircleAvatar(
              child: Text(
                '${index + 1}',
              ),
            ),

            title: Text(
              book.name,
            ),

            subtitle: Text(
              '${book.chapters.length} capítulos',
            ),

            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),

            onTap: () {

              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) => ChapterPage(

                    bookIndex: index,

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