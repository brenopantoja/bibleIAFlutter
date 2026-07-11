import 'package:biblia_ia/core/cache/bible_cache.dart';
import 'package:biblia_ia/features/bible/controllers/bible_controller.dart';
import 'package:biblia_ia/features/bible/datasource/bible_local_datasource.dart';
import 'package:biblia_ia/features/bible/pages/chapter_page.dart';
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

  controller.books = BibleCache.books;
  }

  Future<void> _load() async {
  print('Iniciando carga...');

  try {
    await controller.loadBooks();
    print('Carga concluída');
    print('Quantidade: ${controller.books.length}');
  } catch (e, s) {
    print('ERRO: $e');
    print(s);
  }

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
              itemBuilder: (_, index) {
                final book = controller.books[index];

                return ListTile(
                  leading: const Icon(
                    Icons.menu_book,
                  ),
                  title: Text(book.name),
                  subtitle: Text(
                    '${book.chapters.length} capítulos',
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChapterPage(
                        book: controller.books[index],
                      ),
                    ),
                  );
                },
                );
              },
            ),
    );
  }
}