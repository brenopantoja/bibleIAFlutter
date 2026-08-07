import 'package:bibliaia/core/help/app_font.dart';
import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:bibliaia/core/notifications/notification_scheduler.dart';
import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/core/providers/font_provider.dart';
import 'package:bibliaia/core/routes/app_routes.dart';
import 'package:bibliaia/features/bible/controllers/language_controller.dart';
import 'package:bibliaia/features/home/widgets/verse_of_day_card.dart';
import 'package:bibliaia/features/notifications/widgets/notification_badge.dart';
import 'package:bibliaia/features/search/pages/search_page.dart';
import 'package:bibliaia/features/settings/pages/settings_page.dart';
import 'package:bibliaia/features/verses/controller/verse_controller.dart';
import 'package:bibliaia/features/verses/datasource/verse_remote_datasource.dart';
import 'package:bibliaia/features/verses/page/verse_of_day_page.dart';
import 'package:bibliaia/features/verses/repository/verse_repository.dart';
import 'package:bibliaia/shared/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:bibliaia/features/favorites/pages/favorites_page.dart';

import '../controllers/home_controller.dart';
import '../repository/home_repository.dart';
import '../widgets/backend_status_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends State<HomePage> {

  late final HomeController controller;

  final LanguageController languageController =
    LanguageController();
  late final VerseController verseController;
 
  late Set<String> selectedLanguage;

  @override
  void initState() {
    super.initState();

    controller = HomeController(
      HomeRepository(),
    );

    selectedLanguage = {
      BibleProvider.instance.english ? 'en' : 'pt',
    };

    verseController = VerseController(
      repository: VerseRepository(
        datasource: const VerseRemoteDatasource(),
      ),
    );

    verseController.addListener(_refresh);

    _load();

    BibleProvider.instance.addListener(
      _refresh,
    );

 Future.microtask(() async {
    await NotificationScheduler.instance.showNow();
  });
}
  
void _refresh() {
  if (mounted) {
    setState(() {});
  }
}

@override
void dispose() {

  verseController.removeListener(
    _refresh,
  );

  BibleProvider.instance.removeListener(
    _refresh,
  );

  super.dispose();
}

Future<void> _load() async {
  await Future.wait([
    controller.loadHealth(),
    verseController.load(),
  ]);

  if (mounted) {
    setState(() {});
  }
}
  @override
  Widget build(BuildContext context) {
  final verse = verseController.verse;
  
    return Scaffold(
      drawer: AppDrawer(
        version: controller.version,
      ),
      appBar: AppBar(
        title: const Text(
          'Bible IA',
        ),
        actions: const [
          NotificationBadge(),
          SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  'assets/icons/app_icon.png',
                  width: 110,
                  height: 110,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.welcome,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: FontProvider.instance.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: FontProvider.instance.fontSize,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 18),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search),
                        const SizedBox(width: 22),
                        Expanded(
                          child: Text(
                            AppStrings.search,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: FontProvider.instance.fontSize,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.aiChat,
                    );
                  },
                  icon: const Icon(Icons.auto_awesome),
                  label: Text(
                    AppStrings.askAI,
                    style: TextStyle(
                      fontSize: FontProvider.instance.fontSize,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 18),
              Center(
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'pt',
                      label: Text('Português'),
                    ),
                    ButtonSegment(
                      value: 'en',
                      label: Text('English'),
                    ),
                  ],
                  selected: selectedLanguage,
                  onSelectionChanged: (value) async {
                    final english = value.first == 'en';

                    setState(() {
                      selectedLanguage = value;
                    });

                    await BibleProvider.instance.changeLanguage(english);

                    await verseController.load();

                    if (!mounted) return;

                    setState(() {});

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          english
                              ? 'Bible loaded in English.'
                              : 'Bíblia carregada em Português.',
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (verse != null) ...[
                const SizedBox(height: 12),
                VerseOfDayCard(
                  reference: verse.reference,
                  text: verse.text,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerseOfDayPage(),
                      ),
                    );

                    if (!mounted) return;

                    await verseController.load();
                  },
                ),
              ],
              const SizedBox(height: 30),
              Text(
                AppStrings.quickAccess,
                style: TextStyle(
                  fontSize: AppFont.h2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.menu_book),
                  title: Text(
                    AppStrings.readBible,
                    style: TextStyle(
                      fontSize: AppFont.title,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    AppStrings.readBibleSubtitle,
                    style: TextStyle(
                      fontSize: AppFont.subtitle,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.books,
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.auto_awesome),
                  title: Text(
                    AppStrings.aiChat,
                    style: TextStyle(
                      fontSize: AppFont.title,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    AppStrings.aiChatSubtitle,
                    style: TextStyle(
                      fontSize: AppFont.subtitle,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.aiChat,
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.favorite),
                  title: Text(
                    AppStrings.favorites,
                    style: TextStyle(
                      fontSize: AppFont.title,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    AppStrings.favoritesSubtitle,
                    style: TextStyle(
                      fontSize: AppFont.subtitle,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FavoritesPage(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.today),
                  title: Text(
                    AppStrings.verseOfDay,
                    style: TextStyle(
                      fontSize: AppFont.title,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    AppStrings.verseOfDaySubtitle,
                    style: TextStyle(
                      fontSize: AppFont.subtitle,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerseOfDayPage(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: Text(
                        AppStrings.settings,
                        style: TextStyle(
                          fontSize: AppFont.title,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        AppStrings.settingsDescription,
                        style: TextStyle(
                          fontSize: AppFont.subtitle,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SettingsPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BackendStatusWidget(
                      online: controller.backendOnline,
                      applicationName: controller.applicationName,
                      version: controller.version,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}