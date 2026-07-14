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
  if (!mounted) {
    return;
  }

  _search(controller.text);

  setState(() {});
}

  @override
  void dispose() {

    //BibleProvider.instance.removeListener(
     // _reload,
    //);

    controller.dispose();

    super.dispose();
  }

  void _search(
    String value,
  ) {

    results.clear();

  if (value.trim().isEmpty) {
    results.clear();

    setState(() {});

    return;
}

    final query =
        value.toLowerCase();

    final books =
        BibleProvider.instance.books;

    for (int b = 0;
        b < books.length;
        b++) {

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
            verses[v].text.toLowerCase();

        if (verse.contains(query)) {

            results.add(

              _SearchResult(

                bookIndex: b,

                chapter: c + 1,

                verse: verses[v].number,

                bookName: book.name,

                text: verses[v].text,

              ),

            );

        }
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
debugPrint(
  'SEARCH PAGE -> ${BibleProvider.instance.english}',
);
    final english =
        BibleProvider.instance.english;

    return Scaffold(

      appBar: AppBar(

        title: Text(

          english
              ? 'Search Bible'
              : 'Pesquisar Bíblia',

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

                hintText: english
                    ? 'Type a word...'
                    : 'Digite uma palavra...',

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

                ? Center(

                    child: Text(

                      controller.text
                              .trim()
                              .isEmpty

                          ? (english

                              ? 'Type a word...'

                              : 'Digite uma palavra...')

                          : (english

                              ? 'No results found.'

                              : 'Nenhum resultado encontrado.'),

                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),

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