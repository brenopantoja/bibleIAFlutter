import '../../config/cli_config.dart' as CliConfig;
import '../templates/page_template.dart';
import '../templates/provider_template.dart';
import 'generator.dart';

class FeatureGenerator extends Generator {
  FeatureGenerator(super.name);

  @override
  Future<void> generate() async {
    final root = 'lib/features/$name';

    // Cria a pasta da feature
    await createDirectory(root);

    // Cria as subpastas
    for (final folder in CliConfig.featureFolders) {
      await createDirectory('$root/$folder');
    }

    // Cria a página
    await createFile(
      '$root/pages/${name}_page.dart',
      PageTemplate.build(name),
    );

    // Cria o provider
    await createFile(
      '$root/providers/${name}_provider.dart',
      ProviderTemplate.build(name),
    );

    print('');
    print(' Feature "$name" criada com sucesso.');
  }
}