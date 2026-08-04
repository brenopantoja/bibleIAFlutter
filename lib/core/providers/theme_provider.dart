import 'package:flutter/material.dart';

import '../../features/settings/repository/settings_repository.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider._();

  static final ThemeProvider instance =
      ThemeProvider._();

  final SettingsRepository _repository =
      const SettingsRepository();

  ThemeMode _themeMode =
      ThemeMode.system;

  ThemeMode get themeMode =>
      _themeMode;

  Future<void> initialize() async {
    final settings =
        await _repository.getSettings();

    switch (settings.themeMode) {
      case 'light':
        _themeMode = ThemeMode.light;
        break;

      case 'dark':
        _themeMode = ThemeMode.dark;
        break;

      default:
        _themeMode = ThemeMode.system;
    }

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