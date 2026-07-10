class PageTemplate {
  const PageTemplate._();

  static String build(String name) {
    final className = _capitalize(name);

    return '''
import 'package:flutter/material.dart';

class ${className}Page extends StatelessWidget {

  const ${className}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('$className Page'),
      ),
    );
  }

}
''';
  }

  static String _capitalize(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }
}