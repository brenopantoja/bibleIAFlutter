import 'package:flutter/material.dart';

import '../../features/settings/repository/settings_repository.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider._();

  static final ThemeProvider instance =
      ThemeProvider._();

  final SettingsRepository _repository =
      const SettingsRepository();

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> initialize() async {

    final settings =
        await _repository.getSettings();

    _themeMode = settings.themeMode;

    notifyListeners();
  }

  void setThemeMode(
    ThemeMode mode,
  ) {

    if (_themeMode == mode) {
      return;
    }

    _themeMode = mode;

    notifyListeners();
  }
}