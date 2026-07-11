import 'package:biblia_ia/core/routes/app_routes.dart';
import 'package:biblia_ia/features/search/pages/search_page.dart';
import 'package:biblia_ia/core/cache/bible_cache.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String version;

  const AppDrawer({
    super.key,
    required this.version,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: Colors.blue.shade700,
              child: Column(
                children: [

                  Image.asset(
                    'assets/icons/app_icon.png',
                    width: 90,
                    height: 90,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Bible IA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'A Bíblia com Inteligência Artificial',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(

                children: [

                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.menu_book),
                    title: const Text('Ler Bíblia'),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(
                        context,
                        AppRoutes.books,
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.search),
                    title: const Text('Pesquisar na Bíblia'),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SearchPage(
                            books: BibleCache.books,
                          ),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.auto_awesome),
                    title: const Text('Conversar com IA'),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('Favoritos'),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.today),
                    title: const Text('Versículo do Dia'),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Configurações'),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text('Idioma'),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Sobre'),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const Divider(),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  const Text(
                    'Bible IA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Versão $version',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}