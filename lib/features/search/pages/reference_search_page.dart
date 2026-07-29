import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/features/bible/pages/verses_page.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../controllers/search_controller.dart' as search;
import '../repository/search_repository.dart';

class ReferenceSearchPage extends StatefulWidget {
  const ReferenceSearchPage({
    super.key,
  });

  @override
  State<ReferenceSearchPage> createState() =>
      _ReferenceSearchPageState();
}

class _ReferenceSearchPageState
    extends State<ReferenceSearchPage> {
  late final search.SearchController controller;

  final ItemScrollController _itemScrollController =
    ItemScrollController();

  @override
  void initState() {
    super.initState();

    controller = search.SearchController(
      repository: const SearchRepository(),
    );

    controller.addListener(_refresh);
  }

 void _refresh() {
  if (!mounted) return;

  setState(() {});

  if (controller.state.selectedVerse != null &&
      controller.state.results.isNotEmpty) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = controller.state.results.indexWhere(
        (e) => e.verse == controller.state.selectedVerse,
      );

      if (index != -1) {
        _itemScrollController.scrollTo(
          index: index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }
}

  @override
  void dispose() {
    controller.removeListener(_refresh);
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = controller.state;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.searchReference,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller.textController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                labelText: AppStrings.reference,
                hintText: AppStrings.referenceHint,
                prefixIcon: const Icon(Icons.menu_book),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => controller.search(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: controller.search,
                icon: const Icon(Icons.search),
                label: Text(
                  AppStrings.searchButton,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (state.loading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (state.error != null)
              Expanded(
                child: Center(
                  child: Text(
                    state.error!,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            else if (state.results.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    AppStrings.enterReference,
                  ),
                ),
              )
            else
              Expanded(
                child: ScrollablePositionedList.builder(
                itemScrollController: _itemScrollController,
                itemCount: state.results.length,
                itemBuilder: (context, index) {
                    final verse = state.results[index];

                    final highlight =
                        verse.verse == state.selectedVerse;

                    return Card(
                      color: highlight
                          ? Theme.of(context)
                              .colorScheme
                              .primaryContainer
                          : null,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            verse.verse.toString(),
                          ),
                        ),
                        title: Text(
                          verse.reference,
                        ),
                        subtitle: Text(
                          verse.text,
                        ),
                        onTap: () {
                          final bookIndex = BibleProvider
                              .instance.books
                              .indexWhere(
                            (book) =>
                                book.name.toLowerCase() ==
                                verse.book.toLowerCase(),
                          );

                          if (bookIndex == -1) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppStrings.bookNotFound,
                                ),
                              ),
                            );
                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VersesPage(
                                bookIndex: bookIndex,
                                chapterIndex:
                                    verse.chapter - 1,
                                highlightedVerse:
                                    verse.verse,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}