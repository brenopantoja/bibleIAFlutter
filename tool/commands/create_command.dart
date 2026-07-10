import '../cli/generators/generator_factory.dart';
import '../cli/models/cli_arguments.dart';

import 'command.dart';

class CreateCommand implements Command {
  @override
  Future<void> execute(CliArguments arguments) async {
    final generator = GeneratorFactory.create(
      arguments.type,
      arguments.name,
    );

    await generator.generate();
  }
}