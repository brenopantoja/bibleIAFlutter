 
import '../cli/models/cli_arguments.dart';

abstract class Command {
  Future<void> execute(CliArguments arguments);
}