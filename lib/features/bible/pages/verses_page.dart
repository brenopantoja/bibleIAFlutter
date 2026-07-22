import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/features/favorites/models/favorite_item.dart';
import 'package:bibliaia/features/favorites/models/favorite_type.dart';
import 'package:bibliaia/features/favorites/repository/favorite_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class VersesPage extends StatefulWidget {
  final int bookIndex;
  final int chapterIndex;

final int? highlightedVerse;

const VersesPage({
  super.key,
  required this.bookIndex,
  required this.chapterIndex,
  this.highlightedVerse,
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
          final selected =
    widget.highlightedVerse == index + 1;

          return ListTile(
             tileColor: selected
          ? Colors.amber.withOpacity(0.20)
          : null,
            title: Text(
              verses[index].toString(),
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () async {
                  final verseText = verses[index].toString();

                  final item = FavoriteItem(
                    type: FavoriteType.verse,
                    title:
                        '${book.name} ${widget.chapterIndex + 1}:${index + 1}',
                    description: verseText,
                    text: verseText,
                    language: BibleProvider.instance.english
                        ? 'en'
                        : 'pt',
                    book: book.name,
                    bookIndex: widget.bookIndex,
                    chapter: widget.chapterIndex + 1,
                    verse: index + 1,
                    createdAt: DateTime.now(),
                  );

                  await _repository.toggleFavorite(item);

                  setState(() {
                    if (isFavorite) {
                      _favorites.remove(key);
                    } else {
                      _favorites.add(key);
                    }
                  });

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 1),
                      content: Text(
                        isFavorite
                            ? AppStrings.favoriteRemoved
                            : AppStrings.favoriteAdded,
                      ),
                    ),
                  );
                },
              ),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  final verseText = verses[index].toString();

                  final text = '''
          ${book.name} ${widget.chapterIndex + 1}:${index + 1}

          $verseText
          ''';

                  switch (value) {
                    case 'copy':
                      await Clipboard.setData(
                        ClipboardData(text: text),
                      );

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 1),
                          content: Text(AppStrings.copied),
                        ),
                      );
                      break;

                    case 'share':
                      await Share.share(text);
                      break;
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'copy',
                    child: Row(
                      children: [
                        const Icon(Icons.copy),
                        const SizedBox(width: 8),
                        Text(AppStrings.copy),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'share',
                    child: Row(
                      children: [
                        const Icon(Icons.share),
                        const SizedBox(width: 8),
                        Text(AppStrings.share),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          );
        },
      ),
    );
  }
}