import 'package:flutter/foundation.dart';

class FavoritesController extends ChangeNotifier {

  final List<String> favorites = [];

  void toggle(
    String verse,
  ) {

    if (favorites.contains(verse)) {
      favorites.remove(verse);
    } else {
      favorites.add(verse);
    }

    notifyListeners();
  }
}