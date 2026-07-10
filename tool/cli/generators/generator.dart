import 'dart:io';

abstract class Generator {
  final String name;

  const Generator(this.name);

  Future<void> generate();

  Future<void> createDirectory(String path) async {
    final directory = Directory(path);

    if (!directory.existsSync()) {
      await directory.create(recursive: true);
      print('📁 Diretório criado: $path');
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

    print('📄 Arquivo criado: $path');
  }
}