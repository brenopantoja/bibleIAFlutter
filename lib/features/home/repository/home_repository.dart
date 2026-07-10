import 'package:dio/dio.dart';

import '../../../core/config/app_properties.dart';
import '../models/health_response.dart';

class HomeRepository {
  HomeRepository();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppProperties.baseUrl,
      connectTimeout: AppProperties.connectTimeout,
      receiveTimeout: AppProperties.receiveTimeout,
    ),
  );

  Future<HealthResponse?> health() async {
    try {
      final response = await _dio.get(
        AppProperties.health,
      );

      return HealthResponse.fromJson(response.data);
    } on DioException {
      return null;
    } catch (_) {
      return null;
    }
  }
}