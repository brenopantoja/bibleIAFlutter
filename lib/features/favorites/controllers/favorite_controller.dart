import 'package:flutter/material.dart';

import '../models/favorite_verse.dart';
import '../repository/favorite_repository.dart';

class FavoriteController extends ChangeNotifier {

  FavoriteController({
    FavoriteRepository? repository,
  }) : _repository =
            repository ??
            FavoriteRepository();

  final FavoriteRepository _repository;

  final List<FavoriteVerse> _favorites = [];

  bool _loading = false;

  bool get loading => _loading;

  List<FavoriteVerse> get favorites =>
      List.unmodifiable(_favorites);

  int get total =>
      _favorites.length;

  // Inicializa
  Future<void> loadFavorites() async {

    _loading = true;

    notifyListeners();

    _favorites.clear();

    _favorites.addAll(
      await _repository.findAll(),
    );

    _loading = false;

    notifyListeners();
  }

  // Salvar
   Future<void> save(
    FavoriteVerse verse,
  ) async {

    await _repository.save(
      verse,
    );

    await loadFavorites();
  }

  // Remover
 Future<void> remove(
    FavoriteVerse verse,
  ) async {

    if (verse.id == null) {
      return;
    }

    await _repository.delete(
      verse.id!,
    );

    _favorites.removeWhere(
      (item) =>
          item.id == verse.id,
    );

    notifyListeners();
  }

  // Alternar favorito
   Future<void> toggleFavorite(
    FavoriteVerse verse,
  ) async {

    final exists =
        await _repository.isFavorite(
      verse.reference,
    );

    if (exists) {

      await _repository.deleteByReference(
        verse.reference,
      );

    } else {

      await _repository.save(
        verse,
      );

    }

    await loadFavorites();
  }

  // Verifica favorito
  Future<bool> isFavorite(
    String reference,
  ) async {

    return _repository.isFavorite(
      reference,
    );
  }

  // Limpar tudo
  Future<void> clear() async {

    await _repository.clear();

    _favorites.clear();

    notifyListeners();
  }

  // Atualizar
  Future<void> refresh() async {

    await loadFavorites();
  }
}