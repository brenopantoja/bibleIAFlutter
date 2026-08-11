import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:bibliaia/core/providers/font_provider.dart';
import 'package:bibliaia/features/settings/controllers/settings_controller.dart';
import 'package:bibliaia/features/settings/repository/settings_repository.dart';
import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({
    super.key,
  });

  @override
  State<LanguagePage> createState() =>
      _LanguagePageState();
}

class _LanguagePageState
    extends State<LanguagePage> {
  late final SettingsController controller;

  @override
  void initState() {
    super.initState();

    controller = SettingsController(
      repository: const SettingsRepository(),
    );

    controller.addListener(_refresh);

    FontProvider.instance.addListener(
      _refresh,
    );

    controller.load();
  }

  @override
  void dispose() {
    controller.removeListener(
      _refresh,
    );

    FontProvider.instance.removeListener(
      _refresh,
    );

    controller.dispose();

    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings =
        controller.settings;

    final fontSize =
        FontProvider.instance.fontSize;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.language,
          style: TextStyle(
            fontSize: fontSize + 2,
          ),
        ),
      ),

      body: controller.loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : ListView(
              children: [
                const SizedBox(
                  height: 12,
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Text(
                    'Selecione o idioma utilizado em toda a aplicação.',
                    style: TextStyle(
                      fontSize: fontSize,
                      height: 1.4,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                // PORTUGUÊS
                RadioListTile<String>(
                  value: 'PT_BR',

                  // ignore: deprecated_member_use
                  groupValue:
                      settings.language,

                  title: Text(
                    'Português (Brasil)',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  subtitle: Text(
                    'Interface e Bíblia em português',
                    style: TextStyle(
                      fontSize:
                          fontSize - 2,
                    ),
                  ),

                  secondary: Text(
                    '🇧🇷',
                    style: TextStyle(
                      fontSize:
                          fontSize + 10,
                    ),
                  ),

                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    controller.setLanguage(
                      value,
                    );
                  },
                ),

                // ENGLISH
                RadioListTile<String>(
                  value: 'EN_US',

                  // ignore: deprecated_member_use
                  groupValue:
                      settings.language,

                  title: Text(
                    'English',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  subtitle: Text(
                    'Application and Bible in English',
                    style: TextStyle(
                      fontSize:
                          fontSize - 2,
                    ),
                  ),

                  secondary: Text(
                    '🇺🇸',
                    style: TextStyle(
                      fontSize:
                          fontSize + 10,
                    ),
                  ),

                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    controller.setLanguage(
                      value,
                    );
                  },
                ),
              ],
            ),
    );
  }
}