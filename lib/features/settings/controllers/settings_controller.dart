import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/core/providers/theme_provider.dart';
import 'package:flutter/material.dart';

import '../models/settings.dart';
import '../repository/settings_repository.dart';

class SettingsController extends ChangeNotifier {
  SettingsController({
    required SettingsRepository repository,
  }) : _repository = repository;

  final SettingsRepository _repository;

  Settings _settings = const Settings();

  Settings get settings => _settings;

  bool _loading = false;

  bool get loading => _loading;

Future<void> load() async {
  _loading = true;
  notifyListeners();

  _settings = await _repository.getSettings();

  ThemeProvider.instance.setThemeMode(
    _settings.themeMode,
  );

  await BibleProvider.instance.changeLanguage(
    _settings.language == 'EN_US',
  );

  _loading = false;
  notifyListeners();
}

  Future<void> setThemeMode(
    ThemeMode? themeMode,
  ) async {
    if (themeMode == null) {
      return;
    }

    _settings = _settings.copyWith(
      themeMode: themeMode,
    );

    ThemeProvider.instance.setThemeMode(
      themeMode,
    );

    notifyListeners();

    await _repository.save(
      _settings,
    );
  }

Future<void> setLanguage(
  String language,
) async {

  _settings = _settings.copyWith(
    language: language,
  );

  await BibleProvider.instance.changeLanguage(
    language == 'EN_US',
  );

  notifyListeners();

  await _repository.save(
    _settings,
  );
}

  Future<void> setBibleVersion(
    String version,
  ) async {
    _settings = _settings.copyWith(
      bibleVersion: version,
    );

    notifyListeners();

    await _repository.save(
      _settings,
    );
  }

  Future<void> setFontSize(
    double fontSize,
  ) async {
    _settings = _settings.copyWith(
      fontSize: fontSize,
    );

    notifyListeners();

    await _repository.save(
      _settings,
    );
  }

Future<void> reset() async {
  await _repository.reset();

  _settings = await _repository.getSettings();

  ThemeProvider.instance.setThemeMode(
    _settings.themeMode,
  );

  await BibleProvider.instance.changeLanguage(
    _settings.language == 'EN_US',
  );

  notifyListeners();
}
}