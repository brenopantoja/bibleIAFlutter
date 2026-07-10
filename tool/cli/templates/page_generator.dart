import 'page_template.dart';
import '../generators/generator.dart';

class PageGenerator extends Generator {

  PageGenerator(super.name);

  @override
  Future<void> generate() async {

    final path =
        'lib/features/$name/pages/${name}_page.dart';

    await createFile(
      path,
      PageTemplate.build(name),
    );

    print('✅ Página criada.');

  }

}