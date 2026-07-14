class AppProperties {
  const AppProperties._();

  /// Ambiente
  static const String environment = 'homolog';//homolog or dev(localhost)

  /// Backend
  static const String baseUrl = 'http://192.168.100.6:8080/api';

  /// Timeout
  static const Duration connectTimeout = Duration(seconds: 4);

  static const Duration receiveTimeout = Duration(seconds: 120);

  /// API

  static const String chat = '/chat';

  static const String books = '/books';

  static const String search = '/search';

  static const String verseOfDay = '/verse/daily';

  static const String health = '/health';
}