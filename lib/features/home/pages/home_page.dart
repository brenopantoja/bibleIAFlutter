import 'package:biblia_ia/core/routes/app_routes.dart';
import 'package:biblia_ia/shared/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
import '../repository/home_repository.dart';
import '../widgets/backend_status_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;

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

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Bible IA'),
      ),

      bottomNavigationBar: BackendStatusWidget(
        online: controller.backendStatus.toUpperCase() == 'UP',
        applicationName: controller.applicationName,
        version: controller.version,
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          children: [
      // Logo
      Center(
        child: Image.asset(
          'assets/icons/app_icon.png',
          width: 140,
          height: 140,
        ),
      ),

      const SizedBox(height: 24),
      // Título
      const Text(
        'Bem-vindo ao Bible IA',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 12),

      const Text(
        'Pergunte qualquer assunto bíblico e receba respostas baseadas nas Escrituras.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17,
          color: Colors.black54,
        ),
      ),

      const SizedBox(height: 30),
      // Pesquisa
      TextField(
        decoration: InputDecoration(
          hintText: 'Pesquisar...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),

      const SizedBox(height: 20),
      // Botão IA
      SizedBox(
        height: 55,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.auto_awesome),
          label: const Text(
            'Perguntar à IA',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),

      const SizedBox(height: 25),
      // Idioma
      Center(
        child: SegmentedButton<String>(
          segments: const [

            ButtonSegment(
              value: 'pt',
              icon: Icon(Icons.check),
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
      ),

      const SizedBox(height: 40),
      // Acesso rápido
      const Text(
        'Acesso rápido',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 18),

      Card(
        child: ListTile(
          leading: const Icon(Icons.menu_book),
          title: const Text('Ler Bíblia'),
          subtitle: const Text(
            'Leia qualquer livro da Bíblia.',
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.books,
            );
          },
        ),
      ),

      const SizedBox(height: 10),

      Card(
        child: ListTile(
          leading: const Icon(Icons.auto_awesome),
          title: const Text('Conversar com IA'),
          subtitle: const Text(
            'Faça perguntas utilizando Inteligência Artificial.',
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ),

      const SizedBox(height: 10),

      Card(
        child: ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('Favoritos'),
          subtitle: const Text(
            'Versículos e pesquisas salvas.',
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ),

      const SizedBox(height: 10),

      Card(
        child: ListTile(
          leading: const Icon(Icons.today),
          title: const Text('Versículo do Dia'),
          subtitle: const Text(
            'Receba inspiração diariamente.',
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ),

      const SizedBox(height: 40),
    ],
  ),
),   );
  }
}