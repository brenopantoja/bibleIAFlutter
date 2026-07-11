import '../../../core/providers/bible_provider.dart';

class LanguageController {

  Future<void> changeLanguage(
    bool english,
  ) async {

    await BibleProvider.instance.load(
      english: english,
    );

  }
}