import 'dart:convert';

import 'package:bibliaia/core/config/app_properties.dart';
import 'package:http/http.dart' as http;

import '../../../core/providers/bible_provider.dart';
import '../models/search_result.dart';

class SearchRemoteDatasource {
  const SearchRemoteDatasource();

  Future<List<SearchResult>> search({
    required String book,
    required int chapter,
  }) async {
    final language =
        BibleProvider.instance.english
            ? 'EN_US'
            : 'PT_BR';

      final uri = Uri.parse(
      '${AppProperties.baseUrl}'
      '${AppProperties.bible}'
      '/$book/$chapter'
      '?language=$language',
      );

    final response =
        await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao consultar Bíblia.',
      );
    }

    final json =
        jsonDecode(response.body) as List;

    return json
        .map(
          (e) => SearchResult.fromMap(e),
        )
        .toList();
  }
}