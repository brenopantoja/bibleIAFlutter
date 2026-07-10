class WidgetTemplate {
  const WidgetTemplate._();

  static String build(String name) {
    final className = _capitalize(name);

    return '''
import 'package:flutter/material.dart';

class ${className}Widget extends StatelessWidget {

  const ${className}Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox();

  }

}
''';
  }

  static String _capitalize(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }
}