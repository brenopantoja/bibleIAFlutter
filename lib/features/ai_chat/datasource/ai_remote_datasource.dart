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

      print('=================================');
      print('ENVIANDO PARA O BACKEND');
      print(
        'POST ${AppProperties.baseUrl}${AppProperties.chat}',
      );
      print(request.toJson());
      print('=================================');

      final response = await _dio.post(
        AppProperties.chat,
        data: request.toJson(),
      );

      print('=================================');
      print('RESPOSTA DO BACKEND');
      print(response.data);
      print('=================================');

      return Map<String, dynamic>.from(
        response.data,
      );

    }  on DioException catch (e) {

  print('==============================');
  print('DIO ERROR');
  print('type: ${e.type}');
  print('message: ${e.message}');
  print('error: ${e.error}');
  print('response: ${e.response}');
  print('statusCode: ${e.response?.statusCode}');
  print('body: ${e.response?.data}');
  print('==============================');

  throw Exception(
    e.message,
  );

    }
}
}