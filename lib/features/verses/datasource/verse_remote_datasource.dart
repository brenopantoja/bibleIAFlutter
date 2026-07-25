import 'dart:convert';

import 'package:bibliaia/core/config/app_properties.dart';
import 'package:http/http.dart' as http;

import '../models/verse_of_day.dart';

class VerseRemoteDatasource {
  const VerseRemoteDatasource();

  Future<VerseOfDay> getVerse(
    String language,
  ) async {
    final uri = Uri.parse(
      
      '${AppProperties.baseUrl}${AppProperties.verseOfDay}',
    ).replace(
      queryParameters: {
        'language': language,
      },
    );

    final response = await http.get(uri);
print(AppProperties.baseUrl);
print(AppProperties.verseOfDay);

  Uri.parse(
  '${AppProperties.baseUrl}${AppProperties.verseOfDay}',
).replace(
  queryParameters: {
    'language': language,
  },
);

print(uri);
    if (response.statusCode != 200) {
  throw Exception(
    'Erro ao buscar versículo. Status: ${response.statusCode}\n${response.body}',
  );
}
    return VerseOfDay.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}