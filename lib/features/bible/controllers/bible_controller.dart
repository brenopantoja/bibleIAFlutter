import 'package:flutter/foundation.dart';

import '../repository/bible_repository.dart';

class BibleController extends ChangeNotifier {
  BibleController({
    required this.repository,
  });

  final BibleRepository repository;

  List books = [];

  bool loading = false;

  Future<void> loadBooks({
  bool english = false,
}) async {
  loading = true;
  notifyListeners();

  books = await repository.getBooks(
    english: english,
  );

  print('Livros carregados: ${books.length}');
  print(books);

  loading = false;
  notifyListeners();
}
}