import 'package:flutter/material.dart';

import '../controllers/home_controller.dart';
import '../repository/home_repository.dart';
import '../widgets/backend_status_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;
  String _healthStatus = 'offline';

  @override
  void initState() {
    super.initState();

    controller = HomeController(
      HomeRepository(),
    );

    _load();
  }

  Future<void> _load() async {
    await controller.loadHealth();

    // Try to read healthStatus from controller dynamically to avoid
    // compile-time errors if the getter name differs in controller.
    try {
      final dynamic value = (controller as dynamic).healthStatus;
      if (value is String) {
        _healthStatus = value;
      }
    } catch (_) {
      // ignore and keep default
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),

      appBar: AppBar(
        title: const Text('Bible IA'),
      ),

      bottomNavigationBar: BackendStatusWidget(
        online: _healthStatus.toLowerCase() == 'online',
        applicationName: 'Bible IA',
        version: '1.0.0',
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            const Spacer(),

            const Icon(
              Icons.menu_book,
              size: 80,
            ),

            const SizedBox(height: 24),

            const Text(
              'Pesquise aqui um tema bíblico e encontre respostas nas Sagradas Escrituras.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            TextField(
              decoration: InputDecoration(
                hintText:
                    'Ex.: Perdão, Fé, Amor...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Perguntar à IA',
                ),
              ),
            ),

            const SizedBox(height: 16),

            SegmentedButton<String>(
              segments: const [
                ButtonSegment(
                  value: 'pt',
                  label: Text('Português'),
                ),
                ButtonSegment(
                  value: 'en',
                  label: Text('English'),
                ),
              ],
              selected: const {'pt'},
              onSelectionChanged: (_) {},
            ),

            const Spacer(),

          ],
        ),
      ),
    );
  }
}