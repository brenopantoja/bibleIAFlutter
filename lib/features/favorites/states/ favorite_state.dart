// ignore: file_names
import '../models/favorite_verse.dart';

class FavoriteState {

  final bool loading;

  final List<FavoriteVerse> favorites;

  const FavoriteState({

    this.loading = false,

    this.favorites = const [],

  });

}