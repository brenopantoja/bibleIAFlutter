import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:flutter/material.dart';

import '../../../core/localization/app_strings.dart';

import '../controllers/settings_controller.dart';
import '../repository/settings_repository.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() =>
      _SettingsPageState();
}

class _SettingsPageState
    extends State<SettingsPage> {

  late final SettingsController controller;

  @override
  void initState() {
    super.initState();

    controller = SettingsController(
      repository:
          const SettingsRepository(),
    );

    controller.addListener(_refresh);
  
    BibleProvider.instance.addListener(
    _refresh,
  );
    controller.load();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.removeListener(
      _refresh,
    );

  BibleProvider.instance.removeListener(
    _refresh,
  );
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final settings =
        controller.settings;

    return Scaffold(

      appBar: AppBar(
        title: Text(
          AppStrings.settings,
        ),
      ),

      body: controller.loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : ListView(

              children: [
                ListTile(

                  title: Text(
                    AppStrings.language,
                  ),

                 subtitle: Text(
                  settings.language == 'EN_US'
                      ? AppStrings.languageEnglish
                      : AppStrings.languagePortuguese,
                ),

                  trailing:
                      DropdownButton<String>(

                    value: settings.language,

                    items: const [

                      DropdownMenuItem(
                        value: 'PT_BR',
                        child: Text(
                          'Português',
                        ),
                      ),

                      DropdownMenuItem(
                        value: 'EN_US',
                        child: Text(
                          'English',
                        ),
                      ),

                    ],

                    onChanged: (value) {

                      if (value == null) {
                        return;
                      }

                      controller.setLanguage(
                        value,
                      );

                    },

                  ),

                ),

                const Divider(),

                ListTile(

                  title: Text(
                        AppStrings.language,

                  ),

                  subtitle: Text(
                    settings.themeMode.toString().split('.').last,
                  ),

                  trailing:
                      DropdownButton<String>(

                    value: settings.themeMode.toString().split('.').last,

                    items: [
                    DropdownMenuItem(
                      value: 'system',
                      child: Text(
                        AppStrings.system,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'light',
                      child: Text(
                        AppStrings.light,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'dark',
                      child: Text(
                        AppStrings.dark,
                      ),
                    ),
                  ],

                    onChanged: (value) {

                      if (value == null) {
                        return;
                      }

                      final themeMode = ThemeMode.values.firstWhere(
                        (mode) => mode.toString().split('.').last == value,
                        orElse: () => ThemeMode.system,
                      );

                      controller.setThemeMode(
                        themeMode,
                      );

                    },

                  ),

                ),

                const Divider(),

                ListTile(

                  title: Text(
                      AppStrings.bibleVersion,

                  ),

                  subtitle: Text(
                    settings.bibleVersion,
                  ),

                  trailing:
                      DropdownButton<String>(

                    value:
                        settings.bibleVersion,

                    items: const [

                      DropdownMenuItem(
                        value: 'ACF',
                        child: Text('ACF'),
                      ),

                      DropdownMenuItem(
                        value: 'KJV',
                        child: Text('KJV'),
                      ),

                    ],

                    onChanged: (value) {

                      if (value == null) {
                        return;
                      }

                      controller
                          .setBibleVersion(
                        value,
                      );

                    },

                  ),

                ),

                const Divider(),

                Padding(

                  padding:
                      const EdgeInsets.all(16),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                          AppStrings.fontSize,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium,
                      ),

                      Slider(

                        min: 12,

                        max: 30,

                        divisions: 9,

                        value:
                            settings.fontSize,

                        label: settings.fontSize
                            .toStringAsFixed(0),

                        onChanged: (value) {

                          controller
                              .setFontSize(
                            value,
                          );

                        },

                      ),

                    ],

                  ),

                ),

                Padding(

                  padding:
                      const EdgeInsets.all(16),

                  child: FilledButton.icon(

                    onPressed:
                        controller.reset,

                    icon: const Icon(
                      Icons.refresh,
                    ),

                    label: Text(
                       AppStrings.restoreDefaults,

                    ),

                  ),

                ),

              ],

            ),

    );
  }
}