import 'dart:io';

 import 'package:flutter/material.dart';

import '../cli/models/cli_arguments.dart';
import 'command.dart';

class DoctorCommand implements Command {
  @override
  Future<void> execute(CliArguments arguments) async {
    debugPrint('');
    debugPrint('🩺 Bible IA Doctor');
    debugPrint('');

    _checkDirectory('lib');
    _checkDirectory('assets');
    _checkDirectory('tool');

    _checkFile('pubspec.yaml');

    debugPrint('');
    debugPrint(' Verificação concluída.');
  }

  void _checkDirectory(String path) {
    if (Directory(path).existsSync()) {
      debugPrint(' Diretório encontrado: $path');
    } else {
      debugPrint('Diretório não encontrado: $path');
    }
  }

  void _checkFile(String path) {
    if (File(path).existsSync()) {
      debugPrint('Arquivo encontrado: $path');
    } else {
      debugPrint('Arquivo não encontrado: $path');
    }
  }
}