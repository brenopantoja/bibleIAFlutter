 import '../../cli/generators/generator.dart' show Generator;
import '../../cli/templates/provider_template.dart' show ProviderTemplate;
  
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