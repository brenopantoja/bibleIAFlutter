class SplashService {
  const SplashService();

  static const splashDuration =
      Duration(milliseconds: 5);

  Future<void> initialize() async {
    await Future.delayed(splashDuration);
  }
}