enum CliOption {
  riverpod,
  bloc,
  clean,
  sqlite,
  dio,
  goRouter;

  static CliOption? fromString(String value) {
    switch (value) {
      case '--riverpod':
        return CliOption.riverpod;

      case '--bloc':
        return CliOption.bloc;

      case '--clean':
        return CliOption.clean;

      case '--sqlite':
        return CliOption.sqlite;

      case '--dio':
        return CliOption.dio;

      case '--gorouter':
        return CliOption.goRouter;

      default:
        return null;
    }
  }
}