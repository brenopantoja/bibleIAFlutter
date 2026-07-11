import 'dart:convert';

import 'package:flutter/services.dart';

class BibleLocalDatasource {
  const BibleLocalDatasource();

  Future<List<dynamic>> loadPortuguese() async {
    final jsonString = await rootBundle.loadString(
      'assets/json/responseBiblePortuguese.json',
    );

    return jsonDecode(jsonString) as List<dynamic>;
  }

  Future<List<dynamic>> loadEnglish() async {
    final jsonString = await rootBundle.loadString(
      'assets/json/responseEnglish.json',
    );

    return jsonDecode(jsonString) as List<dynamic>;
  }
}