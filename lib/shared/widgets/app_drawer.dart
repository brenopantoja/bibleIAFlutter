import 'package:biblia_ia/shared/models/drawer_item.dart';
import 'package:flutter/material.dart';

 
class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
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
              child: ListView.builder(
                itemCount: DrawerItems.items.length,
                itemBuilder: (context, index) {
                  final item = DrawerItems.items[index];

                  return ListTile(
                    leading: Icon(item.icon),
                    title: Text(item.title),
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${item.title} (em desenvolvimento)',
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const Divider(),

            const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [

                  Text(
                    'Bible IA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    'Versão 1.0.0',
                    style: TextStyle(
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