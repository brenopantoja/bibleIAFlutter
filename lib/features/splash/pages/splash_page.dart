import 'package:flutter/material.dart';

import '../../home/pages/home_page.dart';
import '../../home/repository/home_repository.dart';

import '../controllers/splash_controller.dart';
import '../services/splash_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashController controller;

  @override
  void initState() {
    super.initState();

    controller = SplashController(
      homeRepository: HomeRepository(),
      service: const SplashService(),
    );

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  Future<void> _initialize() async {
    await controller.initialize();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }

  @override
  void dispose() {
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
                  width: 180,
                  height: 180,
                ),

                const SizedBox(height: 28),

                const Text(
                  'Bible IA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

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
                  valueColor: const AlwaysStoppedAnimation(
                    Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 40),

                const Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 13,
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