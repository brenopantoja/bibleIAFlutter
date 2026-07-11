import 'package:biblia_ia/core/providers/bible_provider.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });

  @override
  State<SearchPage> createState() =>
      _SearchPageState();
}

class _SearchPageState
    extends State<SearchPage> {

  final TextEditingController controller =
      TextEditingController();

  List<_SearchResult> results = [];

  @override
  void initState() {
    super.initState();

    BibleProvider.instance.addListener(
      _reload,
    );
  }

  void _reload() {
    if (mounted) {
      _search(
        controller.text,
      );
    }
  }

  @override
  void dispose() {

    BibleProvider.instance.removeListener(
      _reload,
    );

    controller.dispose();

    super.dispose();
  }

  void _search(
    String value,
  ) {

    results.clear();

    if (value.trim().isEmpty) {
      setState(() {});
      return;
    }

    final query =
        value.toLowerCase();

    final books =
        BibleProvider.instance.books;

    for (int b = 0; b < books.length; b++) {

      final book = books[b];

      for (int c = 0;
          c < book.chapters.length;
          c++) {

        final verses =
            book.chapters[c];

        for (int v = 0;
            v < verses.length;
            v++) {

          final verse =
              verses[v]
                  .toString();

          if (verse
              .toLowerCase()
              .contains(query)) {

            results.add(

              _SearchResult(

                bookIndex: b,

                chapter: c + 1,

                verse: v + 1,

                bookName: book.name,

                text: verse,

              ),

            );

          }

        }

      }

    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Pesquisar',
        ),
      ),

      body: Column(

        children: [

          Padding(

            padding:
                const EdgeInsets.all(16),

            child: TextField(

              controller: controller,

              autofocus: true,

              decoration:
                  InputDecoration(

                hintText:
                    'Pesquisar na Bíblia',

                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),

              ),

              onChanged: _search,

            ),

          ),

          Expanded(

            child: results.isEmpty

                ? const Center(
                    child: Text(
                      'Nenhum resultado.',
                    ),
                  )

                : ListView.builder(

                    itemCount:
                        results.length,

                    itemBuilder:
                        (_, index) {

                      final item =
                          results[index];

                      return ListTile(

                        leading: const Icon(
                          Icons.menu_book,
                        ),

                        title: Text(
                          item.text,
                        ),

                        subtitle: Text(
                          '${item.bookName} ${item.chapter}:${item.verse}',
                        ),

                        onTap: () {

                          Navigator.pop(
                            context,
                          );

                        },

                      );

                    },

                  ),

          ),

        ],

      ),

    );

  }

}

class _SearchResult {

  final int bookIndex;

  final int chapter;

  final int verse;

  final String bookName;

  final String text;

  _SearchResult({

    required this.bookIndex,

    required this.chapter,

    required this.verse,

    required this.bookName,

    required this.text,
  });
}