import 'package:flutter/material.dart';

import '../models/favorite_item.dart';
import '../repository/favorite_repository.dart';

class FavoriteController extends ChangeNotifier {
  FavoriteController({
    FavoriteRepository? repository,
  }) : _repository =
            repository ??
            FavoriteRepository();

  final FavoriteRepository _repository;

  final List<FavoriteItem> _favorites = [];

  bool _loading = false;

  int _total = 0;

  List<FavoriteItem> get favorites =>
      List.unmodifiable(_favorites);

  bool get loading => _loading;

  int get total => _total;

  Future<void> loadFavorites() async {
  _loading = true;
  notifyListeners();

  try {
    _favorites
      ..clear()
      ..addAll(
        await _repository.findAll(),
      );

    _total = _favorites.length;
  } catch (e, s) {
    debugPrint('Erro ao carregar favoritos: $e');
    debugPrint('$s');
  } finally {
    _loading = false;
    notifyListeners();
  }
}

  Future<void> save(
    FavoriteItem item,
  ) async {
    await _repository.save(item);

    await loadFavorites();
  }

  Future<void> remove(
    FavoriteItem item,
  ) async {
    if (item.id != null) {
      await _repository.delete(item.id!);
    } else {
      await _repository.deleteItem(item);
    }

    await loadFavorites();
  }

  Future<void> toggleFavorite(
    FavoriteItem item,
  ) async {
    await _repository.toggleFavorite(item);

    await loadFavorites();
  }

  Future<bool> isFavorite(
    FavoriteItem item,
  ) async {
    return _repository.isFavorite(item);
  }

  Future<void> clear() async {
    await _repository.clear();

    _favorites.clear();

    _total = 0;

    notifyListeners();
  }

  List<FavoriteItem> byType(
    String type,
  ) {
    return _favorites
        .where(
          (e) => e.type.name == type,
        )
        .toList();
  }

  List<FavoriteItem> get verses =>
      byType('verse');

  List<FavoriteItem> get books =>
      byType('book');

  List<FavoriteItem> get chapters =>
      byType('chapter');

  List<FavoriteItem> get searches =>
      byType('search');

  List<FavoriteItem> get aiAnswers =>
      byType('ai');
}