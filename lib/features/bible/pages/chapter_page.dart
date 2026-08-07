import 'package:bibliaia/core/help/app_font.dart';
import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/core/providers/font_provider.dart';
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

    final book = BibleProvider.instance.book(
      widget.bookIndex,
    );

    return Scaffold(

      appBar: AppBar(
      title: Text(
      book.name,
      style: TextStyle(
      fontSize: AppFont.title,
      fontWeight: FontWeight.bold,
          ),
        ),
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
              style: TextStyle(
                fontSize: AppFont.subtitle,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
            title: Text(
        '${AppStrings.chapter} ${index + 1}',
            style: TextStyle(
              fontSize: AppFont.body,
              fontWeight: FontWeight.w600,
            ),
          ),

        subtitle: Text(
            '${book.chapters[index].length} ${AppStrings.verses}',
            style: TextStyle(
              fontSize: AppFont.subtitle,
            ),
          ),

            trailing: Icon(
              Icons.arrow_forward_ios,
              size: AppFont.subtitle + 2,
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