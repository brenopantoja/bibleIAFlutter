import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/features/favorites/models/favorite_item.dart';
import 'package:bibliaia/features/favorites/models/favorite_type.dart';
import 'package:bibliaia/features/favorites/repository/favorite_repository.dart';
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
  
 final Set<String> _favorites = {};
 
final FavoriteRepository _repository =
    FavoriteRepository();

  @override
  void initState() {
    super.initState();

    BibleProvider.instance.addListener(
      _reload,
    );
    _loadFavorites();
  }

void _reload() {
  if (!mounted) {
    return;
  }

  _loadFavorites();
  _search(controller.text);
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

  final query = value.toLowerCase();

  final books = BibleProvider.instance.books;

  for (int b = 0; b < books.length; b++) {
    final book = books[b];

    for (int c = 0; c < book.chapters.length; c++) {
      final verses = book.chapters[c];

      for (int v = 0; v < verses.length; v++) {
        final verseText = verses[v].text;

        if (verseText
            .toLowerCase()
            .contains(query)) {
          results.add(
            _SearchResult(
              bookIndex: b,
              chapter: c + 1,
              verse: verses[v].number,
              bookName: book.name,
              text: verseText,
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
                itemCount: results.length,
                itemBuilder: (_, index) {
                  final item = results[index];
debugPrint(
  'Renderizando ${item.bookName} ${item.chapter}:${item.verse}',
);
                  final key = _favoriteKey(
                    item.bookName,
                    item.chapter,
                    item.verse,
                  );

                  final isFavorite =
                      _favorites.contains(key);

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

                    trailing: IconButton(
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        final favorite = FavoriteItem(
                          type: FavoriteType.verse,
                          title:
                              '${item.bookName} ${item.chapter}:${item.verse}',
                          description: item.text,
                          text: item.text,
                          language:
                              BibleProvider.instance.english
                                  ? 'en'
                                  : 'pt',
                          book: item.bookName,
                          chapter: item.chapter,
                          verse: item.verse,
                          createdAt: DateTime.now(),
                        );

                        await _repository.toggleFavorite(
                          favorite,
                        );

                        setState(() {
                          if (isFavorite) {
                            _favorites.remove(key);
                          } else {
                            _favorites.add(key);
                          }
                        });

                        if (!context.mounted) {
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 1),
                          content: Text(
                          isFavorite
                              ? (english
                                  ? 'Removed from favorites.'
                                  : 'Favorito removido.')
                              : (english
                                  ? 'Added to favorites.'
                                  : 'Favorito adicionado.'),
                            ),
                          ),
                        );
                      },
                    ),

                    onTap: () {
                      Navigator.pop(context);
                    },
                  );

                    },

                  ),

          ),

        ],

      ),

    );

  }
  
String _favoriteKey(
  String book,
  int chapter,
  int verse,
) {
  return '$book-$chapter-$verse';
}

Future<void> _loadFavorites() async {
  final items =
      await _repository.getVerses();

  _favorites
    ..clear()
    ..addAll(
      items.map(
        (e) => _favoriteKey(
          e.book!,
          e.chapter!,
          e.verse!,
        ),
      ),
    );

  if (mounted) {
    setState(() {});
  }
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