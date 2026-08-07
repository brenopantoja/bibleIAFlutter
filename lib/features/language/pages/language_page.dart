import 'package:bibliaia/core/localization/app_strings.dart';
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

    controller.load();
  }

  @override
  void dispose() {
    controller.removeListener(
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

    final settings = controller.settings;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.language,
        ),
      ),
      body: controller.loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : ListView(
              children: [

                const SizedBox(height: 12),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Text(
                    'Selecione o idioma utilizado em toda a aplicação.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium,
                  ),
                ),

                const SizedBox(height: 16),

                RadioListTile<String>(
                  value: 'PT_BR',
                  // ignore: deprecated_member_use
                  groupValue:
                      settings.language,
                  title: const Text(
                    'Português (Brasil)',
                  ),
                  subtitle: const Text(
                    'Interface e Bíblia em português',
                  ),
                  secondary: const Text(
                    '🇧🇷',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    if (value == null) return;

                    controller.setLanguage(
                      value,
                    );
                  },
                ),

                RadioListTile<String>(
                  value: 'EN_US',
                  // ignore: deprecated_member_use
                  groupValue:
                      settings.language,
                  title: const Text(
                    'English',
                  ),
                  subtitle: const Text(
                    'Application and Bible in English',
                  ),
                  secondary: const Text(
                    '🇺🇸',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    if (value == null) return;

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