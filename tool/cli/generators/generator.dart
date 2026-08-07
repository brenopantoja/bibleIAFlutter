import 'dart:io';

import 'package:flutter/material.dart';

abstract class Generator {
  final String name;

  const Generator(this.name);

  Future<void> generate();

  Future<void> createDirectory(String path) async {
    final directory = Directory(path);

    if (!directory.existsSync()) {
      await directory.create(recursive: true);
      debugPrint('📁 Diretório criado: $path');
    }
  }

  Future<void> createFile(
    String path,
    String content,
  ) async {
    final file = File(path);

    if (!file.existsSync()) {
      await file.create(recursive: true);
    }

    await file.writeAsString(content);

    debugPrint('📄 Arquivo criado: $path');
  }
}