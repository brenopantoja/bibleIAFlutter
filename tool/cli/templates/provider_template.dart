class ProviderTemplate {
  const ProviderTemplate._();

  static String build(String name) {
    return '''
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ${name}Provider = Provider((ref) {

  throw UnimplementedError();

});
''';
  }
}