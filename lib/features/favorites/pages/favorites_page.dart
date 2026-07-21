import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:flutter/material.dart';

import '../controllers/favorite_controller.dart';
import '../models/favorite_item.dart';
import '../models/favorite_type.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavoriteController _controller = FavoriteController();

  @override
  void initState() {
    super.initState();
    _controller.loadFavorites();

    BibleProvider.instance.addListener(_reload);
  }

  void _reload() {
    if (!mounted) return;

    setState(() {});
  }

  @override
  void dispose() {
    BibleProvider.instance.removeListener(_reload);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.favorites),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_controller.favorites.isEmpty) {
            return Center(
              child: Text(AppStrings.noFavorites),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  16,
                  20,
                  8,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${_controller.total} '
                      '${_controller.total == 1 ? (AppStrings.english ? "favorite" : "favorito") : (AppStrings.english ? "favorites" : "favoritos")}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _controller.favorites.length,
                  itemBuilder: (context, index) {
                    final item = _controller.favorites[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: Icon(
                          _icon(item.type),
                        ),
                        title: Text(
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              item.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _subtitle(item),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall,
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                          onPressed: () async {
                            await _controller.remove(item);
                          },
                        ),
                        onTap: () {
                          _showDetails(item);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  IconData _icon(FavoriteType type) {
    switch (type) {
      case FavoriteType.verse:
        return Icons.menu_book;

      case FavoriteType.chapter:
        return Icons.article;

      case FavoriteType.book:
        return Icons.library_books;

      case FavoriteType.ai:
        return Icons.smart_toy;

      case FavoriteType.search:
        return Icons.search;
    }
  }

  String _subtitle(FavoriteItem item) {
    switch (item.type) {
      case FavoriteType.verse:
        return '${item.book} ${item.chapter}:${item.verse}';

      case FavoriteType.chapter:
        return '${item.book} ${item.chapter}';

      case FavoriteType.book:
        return item.book ?? '';

      case FavoriteType.ai:
        return AppStrings.aiChat;

      case FavoriteType.search:
        final isEnglish =
            Localizations.localeOf(context).languageCode == 'en';
        return isEnglish ? 'Search' : 'Pesquisa';
    }
  }

  void _showDetails(FavoriteItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item.text ?? item.description,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}