import 'package:bibliaia/core/providers/font_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/localization/app_strings.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({
    super.key,
    required this.version,
  });

  final String version;

  @override
  State<AboutPage> createState() =>
      _AboutPageState();
}

class _AboutPageState
    extends State<AboutPage> {

  @override
  void initState() {
    super.initState();

    FontProvider.instance.addListener(
      _refresh,
    );
  }

  @override
  void dispose() {
    FontProvider.instance.removeListener(
      _refresh,
    );

    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _openEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'p.engenhariabrasil@gmail.com',
    );

    await launchUrl(uri);
  }

  Future<void> _openWebsite() async {
    final uri = Uri.parse(
      'https://www.p.engenhariabrasil.com',
    );

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final company = AppStrings.english
        ? 'P.Engineering Brazil'
        : 'P.Engenharia Brasil';

    final fontSize =
        FontProvider.instance.fontSize;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.about,
          style: TextStyle(
            fontSize: fontSize + 2,
          ),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [
              const Icon(
                Icons.menu_book_rounded,
                color: Colors.blue,
                size: 90,
              ),

              const SizedBox(
                height: 24,
              ),

              // BIBLE IA
              Text(
                'Bible IA',
                style: TextStyle(
                  fontSize: fontSize + 16,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              // VERSÃO
              Text(
                '${AppStrings.version} ${widget.version}',
                style: TextStyle(
                  fontSize: fontSize + 2,
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              // DESENVOLVIDO POR
              Text(
                AppStrings.developedBy,
                style: TextStyle(
                  fontSize: fontSize + 2,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              // EMPRESA
              Text(
                company,
                style: TextStyle(
                  fontSize: fontSize + 8,
                  fontWeight:
                      FontWeight.w600,
                ),
                textAlign:
                    TextAlign.center,
              ),

              const SizedBox(
                height: 8,
              ),

              // DESENVOLVEDOR
              Text(
                'Breno R. Pantoja',
                style: TextStyle(
                  fontSize: fontSize + 4,
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              // EMAIL
              InkWell(
                onTap: _openEmail,
                borderRadius:
                    BorderRadius.circular(8),

                child: Padding(
                  padding:
                      const EdgeInsets.all(8),

                  child: Column(
                    children: [
                      const Icon(
                        Icons.email_outlined,
                        color: Colors.blue,
                        size: 34,
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        'p.engenhariabrasil@gmail.com',
                        style: TextStyle(
                          fontSize:
                              fontSize - 1,
                          decoration:
                              TextDecoration
                                  .underline,
                          color: Colors.blue,
                        ),
                        textAlign:
                            TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              // WEBSITE
              InkWell(
                onTap: _openWebsite,
                borderRadius:
                    BorderRadius.circular(8),

                child: Padding(
                  padding:
                      const EdgeInsets.all(8),

                  child: Column(
                    children: [
                      const Icon(
                        Icons.language,
                        color: Colors.blue,
                        size: 34,
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        'www.p.engenhariabrasil.com',
                        style: TextStyle(
                          fontSize:
                              fontSize - 1,
                          decoration:
                              TextDecoration
                                  .underline,
                          color: Colors.blue,
                        ),
                        textAlign:
                            TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              // COPYRIGHT
              Text(
                '© 2026 $company',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize:
                      fontSize - 2,
                ),
                textAlign:
                    TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}