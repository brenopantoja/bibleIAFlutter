import 'provider_generator.dart';
import 'feature_generator.dart';
import 'generator.dart';
import 'page_generator.dart';
 import 'widget_generator.dart';

class GeneratorFactory {

  static Generator create(
    String type,
    String name,
  ) {

    switch (type) {

      case 'feature':
        return FeatureGenerator(name);

      case 'page':
        return PageGenerator(name);

      case 'widget':
        return WidgetGenerator(name);

      case 'provider':
        return ProviderGenerator(name);

      default:
        throw Exception('Generator não encontrado.');

    }

  }

}