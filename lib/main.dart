import 'package:bibliaia/core/notifications/notification_service.dart';
import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/core/providers/theme_provider.dart';
import 'package:bibliaia/core/routes/app_pages.dart';
import 'package:bibliaia/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'features/splash/pages/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting(
    'pt_BR',
    null,
  );

  await NotificationService.instance.initialize();

  // Inicializa os providers
  await BibleProvider.instance.initialize();
  await ThemeProvider.instance.initialize();

  runApp(
    const BibleIAApp(),
  );
}

class BibleIAApp extends StatefulWidget {
  const BibleIAApp({
    super.key,
  });

  @override
  State<BibleIAApp> createState() =>
      _BibleIAAppState();
}

class _BibleIAAppState
    extends State<BibleIAApp> {

  @override
  void initState() {
    super.initState();

    ThemeProvider.instance.addListener(
      _refresh,
    );

    BibleProvider.instance.addListener(
      _refresh,
    );
  }

  void _refresh() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  void dispose() {
    ThemeProvider.instance.removeListener(
      _refresh,
    );

    BibleProvider.instance.removeListener(
      _refresh,
    );

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Bible IA',

      theme: AppTheme.light(),

      darkTheme: AppTheme.dark(),

      themeMode:
          ThemeProvider.instance.themeMode,

      routes: AppPages.routes,

      home: const SplashPage(),
    );
  }
}