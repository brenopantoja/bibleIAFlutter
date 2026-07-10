import '../templates/provider_template.dart';
import 'generator.dart';

class ProviderGenerator extends Generator {
  ProviderGenerator(super.name);

  @override
  Future<void> generate() async {
    final path =
        'lib/features/$name/providers/${name}_provider.dart';

    await createFile(
      path,
      ProviderTemplate.build(name),
    );

    print('Provider criado.');
  }
}