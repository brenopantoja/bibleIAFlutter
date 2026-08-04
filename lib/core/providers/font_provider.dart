import 'package:flutter/material.dart';

class FontProvider extends ChangeNotifier {
  FontProvider._();

  static final FontProvider instance =
      FontProvider._();

  double _fontSize = 18;

  double get fontSize => _fontSize;

  Future<void> initialize() async {
    // Futuramente poderá carregar do SQLite.
  }

void setFontSize(double value) {
  print('Novo tamanho: $value');

  if (_fontSize == value) {
    return;
  }

  _fontSize = value;

  notifyListeners();
}

  void reset() {
    _fontSize = 18;

    notifyListeners();
  }

  TextStyle body(
    BuildContext context,
  ) {
    return Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(
          fontSize: _fontSize,
        );
  }
}