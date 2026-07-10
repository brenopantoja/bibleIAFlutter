import '../../../core/config/app_properties.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppProperties.baseUrl,
      connectTimeout: AppProperties.connectTimeout,
      receiveTimeout: AppProperties.receiveTimeout,
    ),
  );

  Future<bool> health() async {
    try {
      final response = await _dio.get(
        AppProperties.health,
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}