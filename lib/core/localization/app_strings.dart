import 'package:bibliaia/core/providers/bible_provider.dart';

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

    static String get history =>
    english ? 'History' : 'Histórico';

    static String get noHistory =>
        english
            ? 'No conversations found.'
            : 'Nenhuma conversa encontrada.';

    static String get delete =>
        english ? 'Delete' : 'Excluir';

    static String get conversation =>
        english ? 'Conversation' : 'Conversa';

    static String get clearConversation =>
        english
            ? 'Clear conversation'
            : 'Limpar conversa';

    static String get historyEmptyDescription =>
        english
            ? 'Start a conversation with Bible IA.'
        : 'Inicie uma conversa com o Bible IA.';

    static String get noFavorites =>
      english
        ? 'No favorite verses.'
        : 'Nenhum versículo favoritado.';

    static String get languagePortuguese =>
    english
    ? 'Portuguese'
    : 'Português';

    static String get languageEnglish =>
    english
    ? 'English'
        : 'Inglês';

    static String get share =>
    english
    ? 'Share'
    : 'Compartilhar';

    static String get copy =>
    english
    ? 'Copy'
    : 'Copiar';

    static String get remove =>
    english
    ? 'Remove'
    : 'Remover';

    static String get favorite =>
    english
    ? 'Favorite'
    : 'Favorito';

    static String get favoritesEmptyDescription =>
    english
    ? 'Save verses you like to access them quickly.'
    : 'Salve versículos para acessá-los rapidamente.';

    static String get favoriteAdded =>
    english
        ? 'Added to favorites.'
        : 'Favorito adicionado.';

    static String get favoriteRemoved =>
    english
        ? 'Removed from favorites.'
        : 'Favorito removido.';
    
    static String get copied {
       return english
      ? 'Copied to clipboard.'
      : 'Copiado para a área de transferência.';
        }

  static String get addFavorite =>
    english
        ? 'Add to favorites'
        : 'Adicionar aos favoritos';

  static String get removeFavorite =>
    english
        ? 'Remove favorite'
        : 'Remover dos favoritos';

  static String get refreshVerse =>
    english
        ? 'New Verse'
        : 'Novo Versículo';

  static String get loadingVerse =>
    english
        ? 'Loading verse...'
        : 'Carregando versículo...';

  static String get failedLoadVerse =>
    english
        ? 'Unable to load verse.'
        : 'Não foi possível carregar o versículo.';

  static String get verseReference =>
    english
        ? 'Reference'
        : 'Referência';

  static String get todaysVerse =>
    english
        ? "Today's Verse"
        : 'Versículo de Hoje';

  static String get viewChapter =>
    english
        ? 'View chapter'
        : 'Ver capítulo';

        static String get notifications =>
    english
        ? 'Notifications'
        : 'Notificações';

  static String get markAllAsRead =>
      english
          ? 'Mark all as read'
          : 'Marcar todas como lidas';

  static String get deleteAllNotifications =>
      english
          ? 'Delete all'
          : 'Excluir todas';

  static String get deleteNotifications =>
      english
          ? 'Delete notifications'
          : 'Excluir notificações';

  static String get deleteNotificationsMessage =>
      english
          ? 'Do you want to remove all notifications?'
          : 'Deseja remover todas as notificações?';

  static String get cancel =>
      english
          ? 'Cancel'
          : 'Cancelar';

  static String get markAsRead =>
      english
          ? 'Mark as read'
          : 'Marcar como lida';

  static String get notificationsEmpty =>
      english
          ? 'No notifications found.'
          : 'Nenhuma notificação encontrada.';

  static String get notificationsEmptyDescription =>
      english
          ? 'When you receive a verse, it will appear here.'
          : 'Quando você receber um versículo, ele aparecerá aqui.';

  static String get notification =>
      english
          ? 'Notification'
          : 'Notificação';

  static String get goToVerse =>
    english
        ? 'Go to verse'
        : 'Ir para o versículo';

      static String get searchReference =>
      english
      ? 'Search Reference'
      : 'Pesquisar Referência';

      static String get reference =>
      english
      ? 'Reference'
      : 'Referência';

      static String get referenceHint =>
      english
      ? 'Ex.: John 3:16'
      : 'Ex.: João 3:16';

      static String get searchButton =>
      english
      ? 'Search'
      : 'Pesquisar';

      static String get enterReference =>
      english
      ? 'Enter a Bible reference.'
      : 'Informe uma referência bíblica.';

      static String get invalidReference =>
      english
      ? 'Invalid reference.'
      : 'Referência inválida.';

      static String get bookNotFound =>
      english
          ? 'Book not found.'
          : 'Livro não encontrado.';

  static String get searchReferenceDescription =>
      english
          ? 'Search for a chapter or specific verse.'
          : 'Pesquise um capítulo ou um versículo específico.';

  static String get exampleReference =>
      english
          ? 'Examples: John 3 or John 3:16'
          : 'Exemplos: João 3 ou João 3:16';

  static String get noReferenceResults =>
      english
          ? 'No verses found.'
          : 'Nenhum versículo encontrado.';

  static String get openChapter =>
      english
          ? 'Open chapter'
          : 'Abrir capítulo';

  static String get loadingSearch =>
      english
          ? 'Searching...'
          : 'Pesquisando...';

  static String get developedBy =>
    english
        ? 'Developed by'
        : 'Desenvolvido por';

    static String get company =>
    english
    ? 'P.Engineering Brazil'
    : 'P.Engenharia Brasil';

    static String get email =>
    'p.engenhariabrasil@gmail.com';

    static String get website =>
    'www.p.engenhariabrasil.com';
    }