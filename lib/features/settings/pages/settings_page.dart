import 'package:bibliaia/core/providers/bible_provider.dart';
import 'package:bibliaia/core/providers/font_provider.dart';
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
      repository: const SettingsRepository(),
    );

    controller.addListener(_refresh);

    BibleProvider.instance.addListener(
      _refresh,
    );

    FontProvider.instance.addListener(
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

    FontProvider.instance.removeListener(
      _refresh,
    );

    controller.dispose();

    super.dispose();
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
          AppStrings.settings,
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
                // IDIOMA
                ListTile(
                  title: Text(
                    AppStrings.language,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  subtitle: Text(
                    settings.language == 'EN_US'
                        ? AppStrings
                            .languageEnglish
                        : AppStrings
                            .languagePortuguese,
                    style: TextStyle(
                      fontSize:
                          fontSize - 2,
                    ),
                  ),

                  trailing:
                      DropdownButton<String>(
                    value:
                        settings.language,

                    style: TextStyle(
                      fontSize: fontSize,
                      color: Theme.of(
                        context,
                      )
                          .colorScheme
                          .onSurface,
                    ),

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
                // TEMA
                ListTile(
                  title: Text(
                    'Tema',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  subtitle: Text(
                    settings.themeMode
                        .toString()
                        .split('.')
                        .last,
                    style: TextStyle(
                      fontSize:
                          fontSize - 2,
                    ),
                  ),

                  trailing:
                      DropdownButton<String>(
                    value: settings.themeMode
                        .toString()
                        .split('.')
                        .last,

                    style: TextStyle(
                      fontSize: fontSize,
                      color: Theme.of(
                        context,
                      )
                          .colorScheme
                          .onSurface,
                    ),

                    items: [
                      DropdownMenuItem(
                        value: 'system',
                        child: Text(
                          AppStrings.system,
                          style: TextStyle(
                            fontSize:
                                fontSize,
                          ),
                        ),
                      ),

                      DropdownMenuItem(
                        value: 'light',
                        child: Text(
                          AppStrings.light,
                          style: TextStyle(
                            fontSize:
                                fontSize,
                          ),
                        ),
                      ),

                      DropdownMenuItem(
                        value: 'dark',
                        child: Text(
                          AppStrings.dark,
                          style: TextStyle(
                            fontSize:
                                fontSize,
                          ),
                        ),
                      ),
                    ],

                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }

                      final themeMode =
                          ThemeMode.values
                              .firstWhere(
                        (mode) =>
                            mode
                                .toString()
                                .split('.')
                                .last ==
                            value,
                        orElse: () =>
                            ThemeMode.system,
                      );

                      controller
                          .setThemeMode(
                        themeMode,
                      );
                    },
                  ),
                ),

                const Divider(),

                // TAMANHO DA FONTE
                Padding(
                  padding:
                      const EdgeInsets.all(
                    16,
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [
                      Text(
                        AppStrings.fontSize,
                        style: TextStyle(
                          fontSize:
                              fontSize,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Slider(
                        min: 12,
                        max: 30,
                        divisions: 9,
                        value:
                            settings.fontSize,
                        label: settings.fontSize
                            .toStringAsFixed(
                          0,
                        ),
                        onChanged: (value) {
                          controller
                              .setFontSize(
                            value,
                          );
                        },
                      ),

                      Center(
                        child: Text(
                          settings.fontSize
                              .toStringAsFixed(
                            0,
                          ),
                          style: TextStyle(
                            fontSize:
                                fontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // RESTAURAR PADRÕES
                Padding(
                  padding:
                      const EdgeInsets.all(
                    16,
                  ),

                  child:
                      SizedBox(
                    width:
                        double.infinity,
                    height:
                        fontSize + 32,

                    child:
                        FilledButton.icon(
                      onPressed:
                          controller.reset,

                      icon: Icon(
                        Icons.refresh,
                        size:
                            fontSize + 4,
                      ),

                      label: Text(
                        AppStrings
                            .restoreDefaults,
                        style: TextStyle(
                          fontSize:
                              fontSize,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}