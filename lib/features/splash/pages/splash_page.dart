import 'package:flutter/material.dart';

import 'package:bibliaia/features/home/controllers/home_controller.dart';
import 'package:bibliaia/features/home/pages/home_page.dart';
import 'package:bibliaia/features/home/repository/home_repository.dart';

import '../controllers/splash_controller.dart';
import '../services/splash_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() =>
      _SplashPageState();
}

class _SplashPageState
    extends State<SplashPage> {

  late final SplashController controller;

  late final HomeController homeController;

  @override
  void initState() {

    super.initState();

    controller = SplashController(
      homeRepository: HomeRepository(),
      service: const SplashService(),
    );

    homeController = HomeController(
      HomeRepository(),
    );

    controller.addListener(_refresh);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _initialize() async {

    await Future.wait([
      controller.initialize(),
      homeController.loadHealth(),
    ]);

    if (!mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }

  @override
  void dispose() {

    controller.removeListener(
      _refresh,
    );

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final state = controller.state;

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [

              Color(0xFF0D47A1),

              Color(0xFF1565C0),

            ],

          ),

        ),

        child: SafeArea(

          child: Padding(

            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 40,
            ),

            child: Column(

              children: [

                const Spacer(),

                Image.asset(
                  'assets/icons/app_icon.png',
                  width: 120,
                  height: 120,
                ),

                const SizedBox(
                  height: 28,
                ),

                const Text(
                  'Bible IA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                const Text(
                  'A Bíblia com Inteligência Artificial',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                  ),
                ),

                const Spacer(),

                LinearProgressIndicator(
                  value: state.progress,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(20),
                  backgroundColor: Colors.white24,
                  valueColor:
                      const AlwaysStoppedAnimation(
                    Colors.white,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                Text(
                  'Versão ${homeController.version}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

              ],

            ),

          ),

        ),

      ),

    );
  }
}