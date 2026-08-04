import '../datasource/settings_local_datasource.dart';
import '../models/settings.dart';

class SettingsRepository {
  const SettingsRepository({
    this.datasource =
        const SettingsLocalDatasource(),
  });

  final SettingsLocalDatasource datasource;

  Future<Settings> getSettings() async {
    final settings =
        await datasource.getSettings();

    return settings ??
        const Settings();
  }

  Future<void> save(
    Settings settings,
  ) {
    return datasource.saveOrUpdate(
      settings,
    );
  }

  Future<void> update(
    Settings settings,
  ) {
    return datasource.update(
      settings,
    );
  }

  Future<void> reset() {
    return datasource.reset();
  }

  Future<void> delete() {
    return datasource.delete();
  }
}