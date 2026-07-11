import 'package:flutter/foundation.dart';

class LanguageController extends ChangeNotifier {

  bool english = false;

  void changeLanguage(
    bool value,
  ) {

    english = value;

    notifyListeners();
  }
}