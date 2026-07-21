import '../datasource/favorite_datasource.dart';
import '../models/favorite_item.dart';

class FavoriteRepository {
  FavoriteRepository({
    FavoriteDatasource? datasource,
  }) : _datasource =
            datasource ??
            FavoriteDatasource();

  final FavoriteDatasource _datasource;

  /// Salvar favorito
  Future<void> save(
    FavoriteItem item,
  ) async {
    final exists =
        await _datasource.exists(
      item,
    );

    if (exists) {
      return;
    }

    await _datasource.save(
      item,
    );
  }

  /// Remove por id
  Future<void> delete(
    int id,
  ) async {
    await _datasource.delete(id);
  }

  /// Remove um favorito
  Future<void> deleteItem(
    FavoriteItem item,
  ) async {
    await _datasource.deleteItem(
      item,
    );
  }

  /// Lista todos
  Future<List<FavoriteItem>>
      findAll() async {
    return _datasource.findAll();
  }

  /// Verifica se existe
  Future<bool> isFavorite(
    FavoriteItem item,
  ) async {
    return _datasource.exists(
      item,
    );
  }

  /// Alterna favorito
  Future<void> toggleFavorite(
    FavoriteItem item,
  ) async {
    final favorite =
        await isFavorite(
      item,
    );

    if (favorite) {
      await deleteItem(
        item,
      );
    } else {
      await save(
        item,
      );
    }
  }

  /// Quantidade
  Future<int> count() async {
    return _datasource.count();
  }

  /// Limpar tudo
  Future<void> clear() async {
    await _datasource.clear();
  }
  // Filtros
  Future<List<FavoriteItem>>
      getVerses() async {
    final list = await findAll();

    return list
        .where(
          (e) =>
              e.type.name == 'verse',
        )
        .toList();
  }

  Future<List<FavoriteItem>>
      getBooks() async {
    final list = await findAll();

    return list
        .where(
          (e) =>
              e.type.name == 'book',
        )
        .toList();
  }

  Future<List<FavoriteItem>>
      getChapters() async {
    final list = await findAll();

    return list
        .where(
          (e) =>
              e.type.name == 'chapter',
        )
        .toList();
  }

  Future<List<FavoriteItem>>
      getSearches() async {
    final list = await findAll();

    return list
        .where(
          (e) =>
              e.type.name == 'search',
        )
        .toList();
  }

  Future<List<FavoriteItem>>
      getAIAnswers() async {
    final list = await findAll();

    return list
        .where(
          (e) =>
              e.type.name == 'ai',
        )
        .toList();
  }
}