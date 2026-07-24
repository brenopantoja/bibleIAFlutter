import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/features/bible/pages/verses_page.dart';
import 'package:flutter/material.dart';

class BibleReferenceController {
  BibleReferenceController._();

  static String convertBibleReferences(String text) {
  final regex = RegExp(
    r'([1-3]?\s?[A-Za-zÀ-ÿ]+(?:\s+[A-Za-zÀ-ÿ]+)*)\s+(\d+):(\d+)(?:-(\d+))?',
  );

  return text.replaceAllMapped(regex, (match) {
    final book = match.group(1)!.trim();
    final chapter = match.group(2)!;
    final verse = match.group(3)!;
    final endVerse = match.group(4);

    final encodedBook = Uri.encodeComponent(book);

    if (endVerse != null) {
      return '[$book $chapter:$verse-$endVerse](verse://$encodedBook/$chapter/$verse)';
    }

    return '[$book $chapter:$verse](verse://$encodedBook/$chapter/$verse)';
  });
}

static Future<void> openVerse(
    BuildContext context,
    String href,
  ) async {
    final uri = Uri.parse(href);

    final book = Uri.decodeComponent(uri.host);

    final segments = uri.pathSegments;

    if (segments.length < 2) {
      return;
    }

    final chapter = int.parse(segments[0]);
    final verse = int.parse(segments[1]);
 
    final aliases = <String, String>{
      'Genesis': 'Gênesis',
      'Exodus': 'Êxodo',
      'Leviticus': 'Levítico',
      'Numbers': 'Números',
      'Deuteronomy': 'Deuteronômio',
      'Joshua': 'Josué',
      'Judges': 'Juízes',
      'Ruth': 'Rute',
      '1 Samuel': '1 Samuel',
      '2 Samuel': '2 Samuel',
      '1 Kings': '1 Reis',
      '2 Kings': '2 Reis',
      '1 Chronicles': '1 Crônicas',
      '2 Chronicles': '2 Crônicas',
      'Ezra': 'Esdras',
      'Nehemiah': 'Neemias',
      'Esther': 'Ester',
      'Job': 'Jó',
      'Psalms': 'Salmos',
      'Proverbs': 'Provérbios',
      'Ecclesiastes': 'Eclesiastes',
      'Song of Solomon': 'Cânticos',
      'Isaiah': 'Isaías',
      'Jeremiah': 'Jeremias',
      'Lamentations': 'Lamentações',
      'Ezekiel': 'Ezequiel',
      'Daniel': 'Daniel',
      'Hosea': 'Oséias',
      'Joel': 'Joel',
      'Amos': 'Amós',
      'Obadiah': 'Obadias',
      'Jonah': 'Jonas',
      'Micah': 'Miqueias',
      'Nahum': 'Naum',
      'Habakkuk': 'Habacuque',
      'Zephaniah': 'Sofonias',
      'Haggai': 'Ageu',
      'Zechariah': 'Zacarias',
      'Malachi': 'Malaquias',
      'Matthew': 'Mateus',
      'Mark': 'Marcos',
      'Luke': 'Lucas',
      'John': 'João',
      'Acts': 'Atos',
      'Romans': 'Romanos',
      '1 Corinthians': '1 Coríntios',
      '2 Corinthians': '2 Coríntios',
      'Galatians': 'Gálatas',
      'Ephesians': 'Efésios',
      'Philippians': 'Filipenses',
      'Colossians': 'Colossenses',
      '1 Thessalonians': '1 Tessalonicenses',
      '2 Thessalonians': '2 Tessalonicenses',
      '1 Timothy': '1 Timóteo',
      '2 Timothy': '2 Timóteo',
      'Titus': 'Tito',
      'Philemon': 'Filemom',
      'Hebrews': 'Hebreus',
      'James': 'Tiago',
      '1 Peter': '1 Pedro',
      '2 Peter': '2 Pedro',
      '1 John': '1 João',
      '2 John': '2 João',
      '3 John': '3 João',
      'Jude': 'Judas',
      'Revelation': 'Apocalipse',
    };

    final localBook = aliases[book] ?? book;

    final books = BibleProvider.instance.books;

    final bookIndex = books.indexWhere(
      (b) => b.name.toLowerCase() == localBook.toLowerCase(),
    );

    if (bookIndex == -1) {
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VersesPage(
          bookIndex: bookIndex,
          chapterIndex: chapter - 1,
          highlightedVerse: verse,
        ),
      ),
    );
  }
}