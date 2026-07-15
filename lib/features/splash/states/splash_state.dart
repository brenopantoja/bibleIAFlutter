// ignore: file_names
import 'package:bibliaia/features/splash/models/splash_step.dart';

 
class SplashState {

  final SplashStep step;

  final double progress;

  final String message;

  const SplashState({
    required this.step,
    required this.progress,
    required this.message,
  });

  SplashState copyWith({
    SplashStep? step,
    double? progress,
    String? message,
  }) {
    return SplashState(
      step: step ?? this.step,
      progress: progress ?? this.progress,
      message: message ?? this.message,
    );
  }

  factory SplashState.initial() {

    return const SplashState(

      step: SplashStep.initializing,

      progress: 0,

      message: 'Inicializando...',

    );

  }

}