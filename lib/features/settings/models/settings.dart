import 'package:flutter/material.dart';

class Settings {
  const Settings({
    this.themeMode = ThemeMode.system,
    this.language = 'PT_BR',
    this.bibleVersion = 'ACF',
    this.fontSize = 18,
  });

  /// Tema do aplicativo
  final ThemeMode themeMode;

  /// Idioma
  /// PT_BR | EN_US
  final String language;

  /// Versão da Bíblia
  /// ACF | KJV | NVI...
  final String bibleVersion;

  /// Tamanho da fonte
  final double fontSize;

  Settings copyWith({
    ThemeMode? themeMode,
    String? language,
    String? bibleVersion,
    double? fontSize,
  }) {
    return Settings(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
      bibleVersion:
          bibleVersion ?? this.bibleVersion,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'themeMode': themeMode.name,
      'language': language,
      'bibleVersion': bibleVersion,
      'fontSize': fontSize,
    };
  }

  factory Settings.fromMap(
    Map<String, dynamic> map,
  ) {
    return Settings(
      themeMode: ThemeMode.values.firstWhere(
        (e) => e.name == map['themeMode'],
        orElse: () => ThemeMode.system,
      ),
      language:
          map['language'] ?? 'PT_BR',
      bibleVersion:
          map['bibleVersion'] ?? 'ACF',
      fontSize:
          (map['fontSize'] ?? 18).toDouble(),
    );
  }

  Map<String, dynamic> toJson() =>
      toMap();

  factory Settings.fromJson(
    Map<String, dynamic> json,
  ) {
    return Settings.fromMap(json);
  }

  @override
  String toString() {
    return '''
Settings(
  themeMode: $themeMode,
  language: $language,
  bibleVersion: $bibleVersion,
  fontSize: $fontSize
)
''';
  }

  @override
  bool operator ==(Object other) {
    return other is Settings &&
        other.themeMode == themeMode &&
        other.language == language &&
        other.bibleVersion ==
            bibleVersion &&
        other.fontSize == fontSize;
  }

  @override
  int get hashCode {
    return Object.hash(
      themeMode,
      language,
      bibleVersion,
      fontSize,
    );
  }
}