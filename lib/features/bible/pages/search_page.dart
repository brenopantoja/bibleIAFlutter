import 'package:flutter/material.dart';

import '../controllers/bible_search_controller.dart';
import '../models/bible_book.dart';

class SearchPage extends StatefulWidget {
  final List<BibleBook> books;

  const SearchPage({
    super.key,
    required this.books,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late BibleSearchController controller;

  @override
  void initState() {
    super.initState();

    controller = BibleSearchController(widget.books);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesquisar"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Digite uma palavra...",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: controller.search,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.results.length,
              itemBuilder: (_, index) {
                final item = controller.results[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(
                      "${item.book} ${item.chapter}:${item.verse}",
                    ),
                    subtitle: Text(item.text),
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