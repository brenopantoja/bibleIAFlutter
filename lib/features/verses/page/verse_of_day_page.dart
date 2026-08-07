 import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/core/providers/font_provider.dart';
import 'package:bibliaia/features/bible/pages/verses_page.dart';
import 'package:bibliaia/features/favorites/models/favorite_item.dart';
import 'package:bibliaia/features/favorites/models/favorite_type.dart';
import 'package:bibliaia/features/favorites/repository/favorite_repository.dart';
import 'package:bibliaia/features/verses/controller/verse_controller.dart';
import 'package:bibliaia/features/verses/datasource/verse_remote_datasource.dart';
import 'package:bibliaia/features/verses/repository/verse_repository.dart';
  
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class VerseOfDayPage extends StatefulWidget {
  const VerseOfDayPage({super.key});

  @override
  State<VerseOfDayPage> createState() => _VerseOfDayPageState();
} 
class _VerseOfDayPageState extends State<VerseOfDayPage> {
  late final VerseController controller;

  final FavoriteRepository _favoriteRepository =
      FavoriteRepository();

  bool _favorite = false;

  @override
  void initState() {
    super.initState();

    controller = VerseController(
      repository: VerseRepository(
        datasource: const VerseRemoteDatasource(),
      ),
    );

    controller.addListener(_refresh);
    FontProvider.instance.addListener(_refresh);
    _reload();
  }

  @override
  void dispose() {
    controller.removeListener(_refresh);
    FontProvider.instance.removeListener(_refresh);
    controller.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _reload() async {
    await controller.load();
    await _loadFavorite();
  }

  Future<void> _loadFavorite() async {
    final verse = controller.verse;

    if (verse == null) {
      _favorite = false;
      return;
    }

    final favorites =
        await _favoriteRepository.getVerses();

    if (!mounted) return;

    setState(() {
      _favorite = favorites.any(
        (e) =>
            e.book == verse.book &&
            e.chapter == verse.chapter &&
            e.verse == verse.verse,
      );
    });
  }

  Future<void> _toggleFavorite() async {
    final verse = controller.verse;

    if (verse == null) return;

    final item = FavoriteItem(
      type: FavoriteType.verse,
      title: verse.reference,
      description: verse.text,
      text: verse.text,
      language: verse.language,
      book: verse.book,
      chapter: verse.chapter,
      verse: verse.verse,
      createdAt: DateTime.now(),
    );

    await _favoriteRepository.toggleFavorite(item);

    if (!mounted) return;

    setState(() {
      _favorite = !_favorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          _favorite
              ? AppStrings.favoriteAdded
              : AppStrings.favoriteRemoved,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final verse = controller.verse;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.verseOfDay),
        actions: [
          IconButton(
            tooltip: AppStrings.refreshVerse,
            icon: const Icon(Icons.refresh),
            onPressed: _reload,
          ),
        ],
      ),
      body: controller.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : verse == null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 24,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          AppStrings.failedLoadVerse,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 18),
                        ElevatedButton.icon(
                          onPressed: _reload,
                          icon: const Icon(Icons.refresh),
                          label: Text(
                            AppStrings.refreshVerse,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _reload,
                  child: ListView(
                    padding: EdgeInsets.all(
                      FontProvider.instance.fontSize,
                    ),
                    children: [
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: _openVerse,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.menu_book,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      verse.reference,
                                      style:  TextStyle(
                                      fontSize: FontProvider.instance.fontSize +2,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                              height: FontProvider.instance.fontSize,
                            ),
                              Text(
                                verse.text,
                                style:  TextStyle(
                              fontSize: FontProvider.instance.fontSize + 2,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          IconButton(
                            tooltip:
                                AppStrings.favorite,
                            icon: Icon(
                              _favorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed:
                                _toggleFavorite,
                          ),
                          IconButton(
                            tooltip: AppStrings.copy,
                            icon: const Icon(
                              Icons.copy,
                            ),
                            onPressed: () async {
                              await Clipboard.setData(
                                ClipboardData(
                                  text:
                                      '${verse.reference}\n\n${verse.text}',
                                ),
                              );

                              if (!mounted) return;

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  duration: const Duration(
                                      seconds: 1),
                                  content: Text(
                                    AppStrings.copied,
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            tooltip:
                                AppStrings.share,
                            icon: const Icon(
                              Icons.share,
                            ),
                            onPressed: () async {
                              await Share.share(
                                '${verse.reference}\n\n${verse.text}',
                              );
                            },
                          ),
                          IconButton(
                            tooltip:
                                AppStrings.refreshVerse,
                            icon: const Icon(
                              Icons.refresh,
                            ),
                            onPressed: _reload,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }
  Future<void> _openVerse() async {
  final verse = controller.verse;

  if (verse == null) return;

  final provider = BibleProvider.instance;

  final books = provider.books;

  final bookIndex = books.indexWhere(
    (b) => b.name.toLowerCase() == verse.book.toLowerCase(),
  );

  if (bookIndex == -1) {
    return;
  }

  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => VersesPage(
        bookIndex: bookIndex,
        chapterIndex: verse.chapter - 1,
        highlightedVerse: verse.verse,
      ),
    ),
  );
}
}