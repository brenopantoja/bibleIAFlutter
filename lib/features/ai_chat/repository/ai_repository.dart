import 'package:biblia_ia/features/ai_chat/datasource/ai_remote_datasource.dart';

import '../models/chat_request.dart';
import '../models/chat_response.dart';

class AiRepository {
  AiRepository({
    required this.datasource,
  });

  final AiRemoteDatasource datasource;

  Future<ChatResponse> ask(
    ChatRequest request,
  ) async {
    final data = await datasource.ask(
      request,
    );

    return ChatResponse.fromJson(
      data,
    );
  }
}