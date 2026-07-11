import 'package:biblia_ia/core/localization/app_strings.dart';
import 'package:biblia_ia/core/providers/bible_provider.dart';
import 'package:biblia_ia/features/bible/pages/chapter_page.dart';
import 'package:flutter/material.dart';

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
        title: Text(
          AppStrings.books,
        ),
      ),

      body: ListView.builder(

        itemCount: books.length,

        itemBuilder: (_, index) {

          final book = books[index];

          return ListTile(

            leading: const Icon(
              Icons.menu_book,
            ),

            title: Text(
              book.name,
            ),

            subtitle: Text(
              '${book.chapters.length} ${AppStrings.chapters}',
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