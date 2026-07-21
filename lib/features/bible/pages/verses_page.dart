import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/features/favorites/models/favorite_item.dart';
import 'package:bibliaia/features/favorites/models/favorite_type.dart';
import 'package:bibliaia/features/favorites/repository/favorite_repository.dart';
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
  State<VersesPage> createState() => _VersesPageState();
}

class _VersesPageState extends State<VersesPage> {
  final FavoriteRepository _repository =
      FavoriteRepository();

  final Set<String> _favorites = {};

  @override
  void initState() {
    super.initState();

    BibleProvider.instance.addListener(_reload);

    _loadFavorites();
  }

  @override
  void dispose() {
    BibleProvider.instance.removeListener(_reload);

    super.dispose();
  }

  void _reload() {
    if (mounted) {
      setState(() {});
    }
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
          final key = _favoriteKey(
            book.name,
            widget.chapterIndex + 1,
            index + 1,
          );

          final isFavorite =
              _favorites.contains(key);

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
              icon: Icon(
                isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () async {
                final item = FavoriteItem(
                  type: FavoriteType.verse,
                  title:
                      '${book.name} ${widget.chapterIndex + 1}:${index + 1}',
                  description:
                      verses[index].toString(),
                  text: verses[index].toString(),
                  language:
                      BibleProvider.instance.english
                          ? 'en'
                          : 'pt',
                  book: book.name,
                  chapter:
                      widget.chapterIndex + 1,
                  verse: index + 1,
                  createdAt: DateTime.now(),
                );

                await _repository
                    .toggleFavorite(item);

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

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  SnackBar(
                    duration: const Duration(
                      seconds: 1,
                    ),
                    content: Text(
                      isFavorite
                          ? 'Favorito removido.'
                          : 'Favorito adicionado.',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}