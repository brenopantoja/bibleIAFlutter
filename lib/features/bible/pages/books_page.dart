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

  int _countVerses(
    List chapters,
  ) {
    return chapters.fold<int>(
      0,
      (total, chapter) =>
          total + (chapter as List).length,
    );
  }

  int _countChapters(
    List books,
  ) {
    return books.fold<int>(
      0,
      (total, book) =>
          total + (book as dynamic).chapters.length as int,
    );
  }

  int _countAllVerses(
    List books,
  ) {
    return books.fold<int>(
      0,
      (total, book) =>
          total + _countVerses(book.chapters),
    );
  }

  Widget _buildTestamentHeader({
    required String title,
    required List books,
  }) {
    final chapters =
        _countChapters(books);

    final verses =
        _countAllVerses(books);

    final fontSize =
        FontProvider.instance.fontSize;

    return Card(
      margin: const EdgeInsets.fromLTRB(
        12,
        16,
        12,
        8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.menu_book,
                  size: fontSize + 6,
                  color: Colors.blue,
                ),

                const SizedBox(
                  width: 10,
                ),

                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: fontSize + 2,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 12,
            ),

            Text(
              '${books.length} ${AppStrings.booksCount} • '
              '$chapters ${AppStrings.chaptersCount} • '
              '$verses ${AppStrings.versesCount}',
              style: TextStyle(
                fontSize:
                    AppFont.subtitle,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookTile({
    required BuildContext context,
    required dynamic book,
    required int index,
  }) {
    final chapters =
        book.chapters.length;

    final verses =
        _countVerses(book.chapters);

    return ListTile(
      leading: Icon(
        Icons.menu_book,
        size:
            FontProvider.instance.fontSize + 4,
      ),

      title: Text(
        book.name,
        style: TextStyle(
          fontSize: AppFont.body,
          fontWeight:
              FontWeight.w600,
        ),
      ),

      subtitle: Text(
        '$chapters ${AppStrings.chaptersCount} • '
        '$verses ${AppStrings.versesCount}',
        style: TextStyle(
          fontSize: AppFont.subtitle,
        ),
      ),

      trailing: Icon(
        Icons.arrow_forward_ios,
        size:
            FontProvider.instance.fontSize,
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
  }

  @override
  Widget build(BuildContext context) {
    final books =
        BibleProvider.instance.books;

    /*
     * A Bíblia protestante possui:
     *
     * 0  -> 38 = Antigo Testamento
     * 39 -> 65 = Novo Testamento
     */

    final oldTestament =
        books.take(39).toList();

    final newTestament =
        books.skip(39).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.books,
          style: TextStyle(
            fontSize:
                FontProvider.instance.fontSize + 2,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        children: [
          // ================================
          // ANTIGO TESTAMENTO
          // ================================

          _buildTestamentHeader(
            title:
                AppStrings.oldTestament,
            books:
                oldTestament,
          ),

          ...oldTestament.asMap().entries.map(
            (entry) {
              final localIndex =
                  entry.key;

              final book =
                  entry.value;

              return _buildBookTile(
                context: context,
                book: book,
                index: localIndex,
              );
            },
          ),

          const Divider(
            height: 32,
            thickness: 1,
          ),

          // ================================
          // NOVO TESTAMENTO
          // ================================

          _buildTestamentHeader(
            title:
                AppStrings.newTestament,
            books:
                newTestament,
          ),

          ...newTestament.asMap().entries.map(
            (entry) {
              final localIndex =
                  entry.key;

              final book =
                  entry.value;

              final originalIndex =
                  39 + localIndex;

              return _buildBookTile(
                context: context,
                book: book,
                index: originalIndex,
              );
            },
          ),

          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}