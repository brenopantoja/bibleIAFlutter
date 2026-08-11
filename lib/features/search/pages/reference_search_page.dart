import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/core/providers/font_provider.dart';
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

    FontProvider.instance.addListener(_refresh);
  }

  void _refresh() {
    if (!mounted) {
      return;
    }

    setState(() {});

    if (controller.state.selectedVerse != null &&
        controller.state.results.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final index =
            controller.state.results.indexWhere(
          (e) =>
              e.verse ==
              controller.state.selectedVerse,
        );

        if (index != -1) {
          _itemScrollController.scrollTo(
            index: index,
            duration:
                const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    controller.removeListener(_refresh);

    FontProvider.instance.removeListener(
      _refresh,
    );

    controller.dispose();

    super.dispose();
  }

  String _errorMessage(String error) {
    final english =
        BibleProvider.instance.english;

    if (error.contains('Referência inválida')) {
      return english
          ? 'Invalid Bible reference.'
          : 'Referência bíblica inválida.';
    }

    if (error.contains('Exception:')) {
      return english
          ? 'Unable to search this reference.'
          : 'Não foi possível pesquisar esta referência.';
    }

    return error;
  }

  @override
  Widget build(BuildContext context) {
    final state = controller.state;

    final fontSize =
        FontProvider.instance.fontSize;

    final english =
        BibleProvider.instance.english;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.searchReference,
          style: TextStyle(
            fontSize: fontSize + 2,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // CAMPO DE REFERÊNCIA
            TextField(
              controller:
                  controller.textController,

              textInputAction:
                  TextInputAction.search,

              style: TextStyle(
                fontSize: fontSize,
              ),

              decoration:
                  InputDecoration(
                labelText:
                    AppStrings.reference,

                labelStyle: TextStyle(
                  fontSize: fontSize,
                ),

                hintText:
                    AppStrings.referenceHint,

                hintStyle: TextStyle(
                  fontSize: fontSize,
                ),

                prefixIcon: Icon(
                  Icons.menu_book,
                  size: fontSize + 4,
                ),

                border:
                    const OutlineInputBorder(),
              ),

              onSubmitted: (_) =>
                  controller.search(),
            ),

            const SizedBox(
              height: 16,
            ),

            // BOTÃO PESQUISAR
            SizedBox(
              width: double.infinity,
              height: fontSize + 32,
              child: FilledButton.icon(
                onPressed:
                    controller.search,

                icon: Icon(
                  Icons.search,
                  size: fontSize + 4,
                ),

                label: Text(
                  AppStrings.searchButton,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            // LOADING
            if (state.loading)
              const Expanded(
                child: Center(
                  child:
                      CircularProgressIndicator(),
                ),
              )

            // ERRO
            else if (state.error != null)
              Expanded(
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(24),
                    child: Text(
                      _errorMessage(
                        state.error!,
                      ),
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              )

            // NENHUM RESULTADO
            else if (state.results.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    AppStrings.enterReference,
                    textAlign:
                        TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                ),
              )

            // RESULTADOS
            else
              Expanded(
                child:
                    ScrollablePositionedList
                        .builder(
                  itemScrollController:
                      _itemScrollController,

                  itemCount:
                      state.results.length,

                  itemBuilder:
                      (context, index) {
                    final verse =
                        state.results[index];

                    final highlight =
                        verse.verse ==
                            state.selectedVerse;

                    return Card(
                      color: highlight
                          ? Theme.of(context)
                              .colorScheme
                              .primaryContainer
                          : null,

                      child: ListTile(
                        leading:
                            CircleAvatar(
                          child: Text(
                            verse.verse
                                .toString(),
                            style: TextStyle(
                              fontSize:
                                  fontSize,
                            ),
                          ),
                        ),

                        title: Text(
                          verse.reference,
                          style: TextStyle(
                            fontSize:
                                fontSize + 2,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(
                          verse.text,
                          style: TextStyle(
                            fontSize:
                                fontSize + 2,
                            height: 1.4,
                          ),
                        ),

                        onTap: () {
                          final bookIndex =
                              BibleProvider
                                  .instance
                                  .books
                                  .indexWhere(
                            (book) =>
                                book.name
                                    .toLowerCase() ==
                                verse.book
                                    .toLowerCase(),
                          );

                          if (bookIndex ==
                              -1) {
                            ScaffoldMessenger
                                .of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppStrings
                                      .bookNotFound,
                                  style:
                                      TextStyle(
                                    fontSize:
                                        fontSize,
                                  ),
                                ),
                              ),
                            );

                            return;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  VersesPage(
                                bookIndex:
                                    bookIndex,
                                chapterIndex:
                                    verse.chapter -
                                        1,
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