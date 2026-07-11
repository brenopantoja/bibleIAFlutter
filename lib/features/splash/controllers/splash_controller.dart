import 'package:flutter/foundation.dart';

import '../../../core/providers/bible_provider.dart';

import '../../home/repository/home_repository.dart';

import '../models/splash_step.dart';
import '../services/splash_service.dart';
import '../states/splash_state.dart';

class SplashController extends ChangeNotifier {
  SplashController({
    required this.homeRepository,
    required this.service,
  });

  final HomeRepository homeRepository;

  final SplashService service;

  SplashState state = SplashState.initial();

  Future<void> initialize() async {
    // Tempo mínimo da Splash
    await service.initialize();

    await _update(
      SplashStep.loadingTheme,
      0.10,
      'Carregando tema...',
    );

    await _update(
      SplashStep.loadingPreferences,
      0.20,
      'Carregando preferências...',
    );

    await _update(
      SplashStep.loadingDatabase,
      0.35,
      'Inicializando banco local...',
    );

    await _update(
      SplashStep.checkingBackend,
      0.50,
      'Verificando Backend...',
    );

    final backend = await homeRepository.health();

    if (backend == null) {
      await _update(
        SplashStep.checkingBackend,
        0.55,
        'Backend Offline',
      );
    } else {
      await _update(
        SplashStep.checkingBackend,
        0.60,
        'Backend Online',
      );
    }

    await _update(
      SplashStep.loadingPortugueseBible,
      0.70,
      'Carregando Bíblia...',
    );

    // Carrega a Bíblia apenas uma vez
    await BibleProvider.instance.initialize();

    await _update(
      SplashStep.preparingAI,
      0.90,
      'Preparando Inteligência Artificial...',
    );

    await _update(
      SplashStep.completed,
      1.00,
      'Concluído.',
    );
  }

  Future<void> _update(
    SplashStep step,
    double progress,
    String message,
  ) async {
    state = state.copyWith(
      step: step,
      progress: progress,
      message: message,
    );

    notifyListeners();

    await Future.delayed(
      const Duration(milliseconds: 120),
    );
  }
}