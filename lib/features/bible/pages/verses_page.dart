import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:flutter/material.dart';

class VersesPage extends StatefulWidget {
  final int bookIndex;
  final int chapterIndex;

  const VersesPage({
    super.key,
    required this.bookIndex,
    required this.chapterIndex,
  });

  @override
  State<VersesPage> createState() =>
      _VersesPageState();
}

class _VersesPageState
    extends State<VersesPage> {

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

    final List verses =
        book.chapters[widget.chapterIndex];

    return Scaffold(

      appBar: AppBar(
        title: Text(
          '${book.name} ${widget.chapterIndex + 1}',
        ),
      ),

      body: ListView.separated(

        itemCount: verses.length,

        separatorBuilder: (_, __) =>
            const Divider(height: 1),

        itemBuilder: (_, index) {

          return ListTile(

            leading: CircleAvatar(
              radius: 16,
              child: Text(
                '${index + 1}',
              ),
            ),

            title: Text(
              verses[index].toString(),
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            trailing: IconButton(

              icon: const Icon(
                Icons.favorite_border,
              ),

              onPressed: () {
                // Sprint Favoritos
              },
            ),
          );
        },
      ),
    );
  }
}