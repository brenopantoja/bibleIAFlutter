 

import '../../cli/models/cli_command.dart';
import '../../cli/models/cli_option.dart';

class CliArguments {
  final CliCommand command;
  final String type;
  final String name;
  final List<CliOption> options;

  const CliArguments({
    required this.command,
    required this.type,
    required this.name,
    this.options = const [],
  });

  bool hasOption(CliOption option) {
    return options.contains(option);
  }

  factory CliArguments.fromArgs(List<String> args) {
    if (args.length < 3) {
      throw Exception('Comando inválido.');
    }

    final command = CliCommand.fromString(args[0]);

    if (command == null) {
      throw Exception('Comando desconhecido.');
    }

    final options = <CliOption>[];

    for (final arg in args.skip(3)) {
      final option = CliOption.fromString(arg);

      if (option != null) {
        options.add(option);
      }
    }

    return CliArguments(
      command: command,
      type: args[1],
      name: args[2],
      options: options,
    );
  }
}