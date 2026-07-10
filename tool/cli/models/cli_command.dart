enum CliCommand {
  create,
  doctor,
  help;

  static CliCommand? fromString(String value) {
    switch (value.toLowerCase()) {
      case 'create':
        return CliCommand.create;

      case 'doctor':
        return CliCommand.doctor;

      case 'help':
        return CliCommand.help;

      default:
        return null;
    }
  }
}