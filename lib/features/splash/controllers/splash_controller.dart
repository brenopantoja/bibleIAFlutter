import 'package:biblia_ia/features/splash/models/splash_step.dart';
import 'package:biblia_ia/features/splash/states/splash_state.dart';
import 'package:flutter/foundation.dart';

import '../../home/repository/home_repository.dart';
import '../services/splash_service.dart';
import '../../../core/cache/bible_cache.dart';
import '../../bible/datasource/bible_local_datasource.dart';
import '../../bible/repository/bible_repository.dart';

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
      SplashStep.loadingPortugueseBible,
      0.75,
      'Carregando Bíblia...',
    );

    final repository = BibleRepository(
      datasource: const BibleLocalDatasource(),
    );

    BibleCache.books = await repository.getBooks(
      english: BibleCache.english,
    );
    
    await _update(
    SplashStep.preparingAI,
    0.97,
    'Preparando aplicação...',
  );
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
      0.40,
      'Inicializando banco local...',
    );

    await _update(
      SplashStep.checkingBackend,
      0.60,
      'Verificando Backend...',
    );

    final backend = await homeRepository.health();

    if (backend == null) {
      await _update(
        SplashStep.checkingBackend,
        0.60,
        'Backend Offline',
      );
    } else {
      await _update(
        SplashStep.checkingBackend,
        0.65,
        'Backend Online',
      );
    }

    await _update(
      SplashStep.loadingPortugueseBible,
      0.75,
      'Carregando Bíblia em Português...',
    );

    await _update(
      SplashStep.loadingEnglishBible,
      0.90,
      'Carregando Bíblia em Inglês...',
    );

    await _update(
      SplashStep.preparingAI,
      0.97,
      'Preparando Inteligência Artificial...',
    );

    await _update(
      SplashStep.completed,
      1.0,
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

    // Tempo entre cada atualização da interface
    await Future.delayed(
      const Duration(milliseconds: 1),
    );
  }
}