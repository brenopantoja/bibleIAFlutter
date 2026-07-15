import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/features/bible/controllers/bible_search_controller.dart';
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

            child: controller
                    .results
                    .isEmpty

                ? Center(

                    child: Text(

                      searchController
                              .text
                              .isEmpty

                          ? (english

                              ? 'Type a word...'

                              : 'Digite uma palavra...')

                          : (english

                              ? 'No results found.'

                              : 'Nenhum resultado encontrado.'),

                    ),

                  )

                : ListView.builder(

                    itemCount:
                        controller
                            .results
                            .length,

                    itemBuilder:
                        (_, index) {

                      final item =
                          controller
                              .results[index];

                      return Card(

                        margin:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),

                        child: ListTile(

                          leading:
                              const Icon(
                            Icons.menu_book,
                          ),

                          title: Text(

                            '${item.book} ${item.chapter}:${item.verse}',

                          ),

                          subtitle:
                              Text(
                            item.text,
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
}