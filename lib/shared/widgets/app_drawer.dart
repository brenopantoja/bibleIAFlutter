import 'package:biblia_ia/core/localization/app_strings.dart';
import 'package:biblia_ia/core/routes/app_routes.dart';
import 'package:biblia_ia/features/search/pages/search_page.dart';
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

                  Text(
                    AppStrings.drawerSubtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                    title: Text(AppStrings.home),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.menu_book),
                    title: Text(AppStrings.readBible),
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
                    title: Text(AppStrings.search),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const SearchPage(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.auto_awesome),
                    title: Text(AppStrings.aiChat),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        AppRoutes.aiChat,
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: Text(AppStrings.favorites),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.today),
                    title: Text(AppStrings.verseOfDay),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: Text(AppStrings.settings),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(AppStrings.language),
                    onTap: () {},
                  ),

                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text(AppStrings.about),
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
                    '${AppStrings.version} $version',
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