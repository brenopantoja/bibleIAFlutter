import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:flutter/material.dart';

import '../models/search_state.dart';
import '../parser/search_parser.dart';
import '../repository/search_repository.dart';

class SearchController extends ChangeNotifier {
  SearchController({
    required SearchRepository repository,
  }) : _repository = repository;

  final SearchRepository _repository;

  SearchState _state = const SearchState();

  SearchState get state => _state;

  final TextEditingController textController =
      TextEditingController();

  /// Realiza a pesquisa
  Future<void> search() async {
    final query = textController.text.trim();

    if (query.isEmpty) {
      _state = _state.copyWith(
        error: AppStrings.enterReference,
      );

      notifyListeners();
      return;
    }

    try {
      // Limpa resultados anteriores e exibe loading
      _state = _state.copyWith(
        loading: true,
        error: null,
        results: const [],
      );

      notifyListeners();

      final parser = SearchParser.parse(query);

      final verses = await _repository.search(
    book: parser.book,
    chapter: parser.chapter,
  );

  if (verses.isEmpty) {
    _state = SearchState(
      loading: false,
      error: AppStrings.invalidReference,
    );

    notifyListeners();
    return;
  }

  if (parser.verse != null &&
      !verses.any((v) => v.verse == parser.verse)) {
    _state = SearchState(
      loading: false,
      error: AppStrings.invalidReference,
    );

    notifyListeners();
    return;
  }

      _state = SearchState(
        loading: false,
        book: parser.book,
        chapter: parser.chapter,
        selectedVerse: parser.verse,
        results: verses,
      );
    } catch (e) {
      _state = SearchState(
        loading: false,
        error: e.toString(),
      );
    }

    notifyListeners();
  }

  /// Pesquisa diretamente por uma referência
  Future<void> searchReference(
    String reference,
  ) async {
    textController.text = reference;
    await search();
  }

  /// Limpa pesquisa
  void clear() {
    textController.clear();
    _state = const SearchState();
    notifyListeners();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}