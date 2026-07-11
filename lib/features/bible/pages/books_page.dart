import 'package:biblia_ia/features/bible/controllers/bible_controller.dart';
import 'package:biblia_ia/features/bible/datasource/bible_local_datasource.dart';
import 'package:flutter/material.dart';

import '../repository/bible_repository.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late final BibleController controller;

  @override
  void initState() {
    super.initState();

    controller = BibleController(
      repository: BibleRepository(
        datasource: const BibleLocalDatasource(),
      ),
    );

    _load();
  }

  Future<void> _load() async {
    await controller.loadBooks();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livros da Bíblia'),
      ),
      body: controller.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: controller.books.length,
              itemBuilder: (context, index) {
                final book = controller.books[index];

                return ListTile(
                  leading: const Icon(Icons.menu_book),
                  title: Text(book.name),
                  subtitle: Text(
                    '${book.chapters.length} capítulos',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Próxima etapa: abrir os capítulos
                  },
                );
              },
            ),
    );
  }
}