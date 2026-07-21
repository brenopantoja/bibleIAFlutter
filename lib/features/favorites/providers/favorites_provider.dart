// ignore_for_file: unused_import

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../controllers/favorite_controller.dart';

final favoritesProvider =
    ChangeNotifierProvider<FavoriteController>((ref) {

  return FavoriteController();

});