 import 'package:flutter/material.dart';

import '../../../core/providers/bible_provider.dart';
import '../models/verse_of_day.dart';
import '../repository/verse_repository.dart';

class VerseController extends ChangeNotifier {
  VerseController({
    required this.repository,
  });

  final VerseRepository repository;

  VerseOfDay? verse;

  bool loading = false;

  Future<void> load() async {
    loading = true;
    notifyListeners();

    try {
      final language = BibleProvider.instance.english
          ? 'EN_US'
          : 'PT_BR';

      verse = await repository.getVerse(language);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

}