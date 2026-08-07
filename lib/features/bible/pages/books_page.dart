import 'package:bibliaia/core/help/app_font.dart';
import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/core/providers/font_provider.dart';
import 'package:bibliaia/features/bible/pages/chapter_page.dart';
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

    FontProvider.instance.addListener(
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

  FontProvider.instance.removeListener(
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
      style: TextStyle(
      fontSize: FontProvider.instance.fontSize + 2,
      fontWeight: FontWeight.bold,
          ),
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
            style: TextStyle(
            fontSize: AppFont.body,
            fontWeight: FontWeight.w600,
              ),
            ),

            subtitle: Text(
            '${book.chapters.length} ${AppStrings.chapters}',
            style: TextStyle(
            fontSize: AppFont.subtitle,
              ),
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