import 'package:dio/dio.dart';

import '../../../core/config/app_properties.dart';

class SplashRepository {
  SplashRepository();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppProperties.baseUrl,
      connectTimeout: AppProperties.connectTimeout,
      receiveTimeout: AppProperties.receiveTimeout,
    ),
  );

  Future<bool> checkBackend() async {
    try {
      final response = await _dio.get(
        AppProperties.health,
      );

      return response.data['status'] == 'UP';
    } catch (_) {
      return false;
    }
  }
}