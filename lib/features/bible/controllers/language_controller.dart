import 'package:biblia_ia/core/providers/bible_provider.dart';

class LanguageController {
  bool get english =>
      BibleProvider.instance.english;

  String get language =>
      english ? 'en' : 'pt';

  Future<void> changeLanguage(bool english) async {
    await BibleProvider.instance.changeLanguage(
      english,
    );
  }
}