import 'package:flutter/material.dart';

import '../datasource/favorite_datasource.dart';
import '../models/favorite_verse.dart';

class FavoriteRepository {
  FavoriteRepository({
    FavoriteDatasource? datasource,
  }) : _datasource =
            datasource ??
            FavoriteDatasource();

  final FavoriteDatasource _datasource;

  /// Salva um versículo como favorito
  Future<void> save(
    FavoriteVerse verse,
  ) async {
    /*final exists =
        await _datasource.exists(
      verse.reference,
    );*/
debugPrint('==============================');
  debugPrint('SALVANDO FAVORITO');
  debugPrint('reference: ${verse.reference}');
  debugPrint('createdAt: ${verse.createdAt}');
  debugPrint('==============================');
/*
    if (exists) {
      return;
    } */

    await _datasource.save(
      verse,
    );
  }

  /// Remove um favorito pelo id
  Future<void> delete(
    int id,
  ) async {
    await _datasource.delete(id);
  }

  /// Remove pela referência
  Future<void> deleteByReference(
    String reference,
  ) async {
    await _datasource
        .deleteByReference(
      reference,
    );
  }

  /// Lista todos os favoritos
  Future<List<FavoriteVerse>>
      findAll() async {
    return _datasource.findAll();
  }

  /// Verifica se já é favorito
  Future<bool> isFavorite(
    String reference,
  ) async {
    return _datasource.exists(
      reference,
    );
  }

  /// Alterna favorito
  Future<void> toggleFavorite(
    FavoriteVerse verse,
  ) async {
    final favorite =
        await isFavorite(
      verse.reference,
    );

    if (favorite) {
      await deleteByReference(
        verse.reference,
      );
    } else {
      await save(
        verse,
      );
    }
  }

  /// Quantidade de favoritos
  Future<int> count() async {
    return _datasource.count();
  }

  /// Remove todos os favoritos
  Future<void> clear() async {
    await _datasource.clear();
  }
}