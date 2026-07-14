import 'package:biblia_ia/core/providers/bible_provider.dart';

class AppStrings {
  static bool get english =>
      BibleProvider.instance.english;

  static String get appName =>
      'Bible IA';

  static String get welcome =>
      english
          ? 'Welcome to Bible IA'
          : 'Bem-vindo ao Bible IA';

  static String get subtitle =>
      english
          ? 'Ask any biblical question and receive answers based on the Scriptures.'
          : 'Pergunte qualquer assunto bíblico e receba respostas baseadas nas Escrituras.';

  static String get search =>
      english
          ? 'Search the Bible...'
          : 'Pesquisar na Bíblia...';

  static String get askAI =>
      english
          ? 'Ask AI'
          : 'Perguntar à IA';

  static String get quickAccess =>
      english
          ? 'Quick Access'
          : 'Acesso rápido';

  static String get readBible =>
      english
          ? 'Read Bible'
          : 'Ler Bíblia';

  static String get readBibleSubtitle =>
      english
          ? 'Read any book of the Bible.'
          : 'Leia qualquer livro da Bíblia.';

  static String get aiChat =>
      english
          ? 'Chat with AI'
          : 'Conversar com IA';

  static String get aiChatSubtitle =>
      english
          ? 'Ask questions using Artificial Intelligence.'
          : 'Faça perguntas utilizando Inteligência Artificial.';

  static String get favorites =>
      english
          ? 'Favorites'
          : 'Favoritos';

  static String get favoritesSubtitle =>
      english
          ? 'Saved verses and searches.'
          : 'Versículos e pesquisas salvas.';

  static String get verseOfDay =>
      english
          ? 'Verse of the Day'
          : 'Versículo do Dia';

  static String get verseOfDaySubtitle =>
      english
          ? 'Receive daily inspiration.'
          : 'Receba inspiração diariamente.';
  
  static String get home =>
      english ? 'Home' : 'Home';

  static String get settings =>
      english ? 'Settings' : 'Configurações';

  static String get language =>
      english ? 'Language' : 'Idioma';

  static String get about =>
      english ? 'About' : 'Sobre';

  static String get drawerSubtitle =>
    english
        ? 'The Bible with Artificial Intelligence'
        : 'A Bíblia com Inteligência Artificial';

  static String get version =>
      english
          ? 'Version'
          : 'Versão';

          static String get books =>
    english
        ? 'Books of the Bible'
        : 'Livros da Bíblia';

  static String get chapters =>
      english
          ? 'chapters'
          : 'capítulos';

  static String get chapter =>
      english
          ? 'Chapter'
          : 'Capítulo';

  static String get verses =>
      english
          ? 'verses'
          : 'versículos';

          static String get askAnything =>
    english
        ? 'Ask anything about the Bible...'
        : 'Pergunte qualquer assunto bíblico...';

    static String get aiTyping =>
        english
            ? 'Bible IA is typing...'
            : 'Bible IA está digitando...';

    static String get suggestion1 =>
        english
            ? 'Who was King David?'
            : 'Quem foi o rei Davi?';

    static String get suggestion2 =>
        english
            ? 'Explain John 3:16.'
            : 'Explique João 3:16.';

    static String get suggestion3 =>
        english
            ? 'Summarize the Book of Genesis.'
            : 'Resuma o livro de Gênesis.';

    static String get suggestion4 =>
        english
            ? 'Show verses about faith.'
            : 'Mostre versículos sobre fé.';
    }