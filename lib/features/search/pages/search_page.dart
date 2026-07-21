import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/features/bible/controllers/bible_search_controller.dart';
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
final FavoriteRepository _repository =
    FavoriteRepository();

final Set<String> _favorites = {};
  late final BibleSearchController
      controller;

  final TextEditingController
      searchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = BibleSearchController(
      BibleProvider.instance.books,
    );

    BibleProvider.instance.addListener(
      _languageChanged,
    );

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
     _loadFavorites();
  }

  void _languageChanged() {

    controller.search(
      searchController.text,
    );

    setState(() {});
  }

  @override
  void dispose() {

    BibleProvider.instance.removeListener(
      _languageChanged,
    );

    controller.dispose();

    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
                const EdgeInsets.all(
              16,
            ),

            child: TextField(

              controller:
                  searchController,

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
                    const OutlineInputBorder(),

              ),

              onChanged:
                  controller.search,

            ),

          ),

          Expanded(

            child: controller.results.isEmpty

                ? Center(

                    child: Text(

                      searchController.text.isEmpty

                          ? (english ? 'Type a word...' : 'Digite uma palavra...')

                          : (english ? 'No results found.' : 'Nenhum resultado encontrado.'),

                    ),

                  )

                : ListView.builder(
                    itemCount: controller.results.length,
                    itemBuilder: (context, index) {
                      final item = controller.results[index];

                      final key = _favoriteKey(
                        item.book,
                        item.chapter,
                        item.verse,
                      );

                      final isFavorite = _favorites.contains(key);

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.menu_book,
                          ),

                          title: Text(
                            '${item.book} ${item.chapter}:${item.verse}',
                          ),

                          subtitle: Text(
                            item.text,
                          ),

                          trailing: IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              final favorite = FavoriteItem(
                                type: FavoriteType.verse,
                                title: '${item.book} ${item.chapter}:${item.verse}',
                                description: item.text,
                                text: item.text,
                                language: BibleProvider.instance.english ? 'en' : 'pt',
                                book: item.book,
                                chapter: item.chapter,
                                verse: item.verse,
                                createdAt: DateTime.now(),
                              );

                              await _repository.toggleFavorite(favorite);

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

                              final english = BibleProvider.instance.english;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 1),
                                  content: Text(
                                    isFavorite
                                        ? (english ? 'Removed from favorites.' : 'Favorito removido.')
                                        : (english ? 'Added to favorites.' : 'Favorito adicionado.'),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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
  final items = await _repository.getVerses();

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