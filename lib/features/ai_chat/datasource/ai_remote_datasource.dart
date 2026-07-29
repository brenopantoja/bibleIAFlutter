import 'package:dio/dio.dart';

import '../../../core/config/app_properties.dart';
import '../models/chat_request.dart';

class AiRemoteDatasource {
  AiRemoteDatasource();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppProperties.baseUrl,
      connectTimeout: AppProperties.connectTimeout,
      receiveTimeout: AppProperties.receiveTimeout,
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<Map<String, dynamic>> ask(
    ChatRequest request,
  ) async {
    try {
      final response = await _dio.post(
        AppProperties.chat,
        data: request.toJson(),
      );

      return Map<String, dynamic>.from(
        response.data,
      );
    } on DioException catch (e) {
      throw Exception(
        e.message,
      );
    }
  }

}