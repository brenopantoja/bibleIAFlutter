import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
      debugPrint('URL: ${AppProperties.baseUrl}${AppProperties.health}');

      final response = await _dio.get(AppProperties.health);

      debugPrint('STATUS: ${response.statusCode}');
      debugPrint('BODY: ${response.data}');

      return HealthResponse.fromJson(response.data);

    } on DioException catch (e) {
      debugPrint('STATUS: ${e.response?.statusCode}');
      debugPrint('BODY: ${e.response?.data}');
      debugPrint('ERROR: ${e.message}');
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}