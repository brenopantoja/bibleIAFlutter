import 'dart:io';

 import '../cli/models/cli_arguments.dart';
import 'command.dart';

class DoctorCommand implements Command {
  @override
  Future<void> execute(CliArguments arguments) async {
    print('');
    print('🩺 Bible IA Doctor');
    print('');

    _checkDirectory('lib');
    _checkDirectory('assets');
    _checkDirectory('tool');

    _checkFile('pubspec.yaml');

    print('');
    print(' Verificação concluída.');
  }

  void _checkDirectory(String path) {
    if (Directory(path).existsSync()) {
      print(' Diretório encontrado: $path');
    } else {
      print('Diretório não encontrado: $path');
    }
  }

  void _checkFile(String path) {
    if (File(path).existsSync()) {
      print('Arquivo encontrado: $path');
    } else {
      print('Arquivo não encontrado: $path');
    }
  }
}