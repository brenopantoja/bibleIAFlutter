import 'cli/models/cli_arguments.dart';
 
import 'cli/models/cli_command.dart';
import 'commands/create_command.dart';
import 'commands/doctor_command.dart';

Future<void> main(List<String> args) async {
  try {
    if (args.isEmpty) {
      _showHelp();
      return;
    }

    final cliArguments = CliArguments.fromArgs(args);

    switch (cliArguments.command) {
      case CliCommand.create:
        await CreateCommand().execute(cliArguments);
        break;

      case CliCommand.doctor:
        await DoctorCommand().execute(cliArguments);
        break;

      case CliCommand.help:
        _showHelp();
        break;
    }
  } catch (e) {
    print('');
    print('Erro: $e');
    print('');
    _showHelp();
  }
}

void _showHelp() {
  print(r'''

===========================================================
                Bible IA CLI v1.0
===========================================================

Uso:

dart run tool/generate.dart <comando>

-----------------------------------------------------------
CREATE
-----------------------------------------------------------

Criar uma Feature

dart run tool/generate.dart create feature home

Criar uma Página

dart run tool/generate.dart create page login

Criar um Widget

dart run tool/generate.dart create widget app_button

Criar um Provider

dart run tool/generate.dart create provider auth

-----------------------------------------------------------
OPÇÕES
-----------------------------------------------------------

--riverpod
--bloc
--clean
--sqlite
--dio
--gorouter

Exemplo:

dart run tool/generate.dart create feature home --riverpod

dart run tool/generate.dart create feature login --clean

-----------------------------------------------------------
OUTROS COMANDOS
-----------------------------------------------------------

doctor

Exemplo:

dart run tool/generate.dart doctor

help

===========================================================

''');
}