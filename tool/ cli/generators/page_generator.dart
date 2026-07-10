import '../../cli/generators/generator.dart';
 
class PageGenerator extends Generator {
  PageGenerator(super.name);

  @override
  Future<void> generate() async {
    final path =
        'lib/features/$name/pages/${name}_page.dart';

    await createFile(
      path,
      '''
import 'package:flutter/material.dart';

class ${_className(name)}Page extends StatelessWidget {

  const ${_className(name)}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('${_className(name)} Page'),
      ),
    );
  }
}
''',
    );

    print('Página criada.');
  }

  String _className(String value) {
    return value[0].toUpperCase() + value.substring(1);
  }
}