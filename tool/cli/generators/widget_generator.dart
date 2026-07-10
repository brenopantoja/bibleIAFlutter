import 'generator.dart';

class WidgetGenerator extends Generator {
  WidgetGenerator(super.name);

  @override
  Future<void> generate() async {
    final path =
        'lib/shared/widgets/${name}_widget.dart';

    await createFile(
      path,
      '''
import 'package:flutter/material.dart';

class ${_className(name)}Widget extends StatelessWidget {

  const ${_className(name)}Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
''',
    );

    print('Widget criado.');
  }

  String _className(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }
}