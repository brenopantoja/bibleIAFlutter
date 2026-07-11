import 'package:biblia_ia/core/providers/bible_provider.dart';
import 'package:flutter/material.dart';

import 'verses_page.dart';

class ChapterPage extends StatefulWidget {
  final int bookIndex;

  const ChapterPage({
    super.key,
    required this.bookIndex,
  });

  @override
  State<ChapterPage> createState() =>
      _ChapterPageState();
}

class _ChapterPageState
    extends State<ChapterPage> {

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

    final book = BibleProvider.instance.book(
      widget.bookIndex,
    );

    return Scaffold(

      appBar: AppBar(
        title: Text(book.name),
      ),

      body: ListView.separated(

        itemCount: book.chapters.length,

        separatorBuilder: (_, __) =>
            const Divider(height: 1),

        itemBuilder: (_, index) {

          return ListTile(

            leading: CircleAvatar(
              child: Text(
                '${index + 1}',
              ),
            ),

            title: Text(
              'Capítulo ${index + 1}',
            ),

            subtitle: Text(
              '${book.chapters[index].length} versículos',
            ),

            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),

            onTap: () {

              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) => VersesPage(

                    bookIndex: widget.bookIndex,

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