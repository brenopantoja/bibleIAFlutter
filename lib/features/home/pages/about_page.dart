import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/localization/app_strings.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
    super.key,
    required this.version,
  });

  final String version;

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

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.about),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.menu_book_rounded,
                color: Colors.blue,
                size: 90,
              ),

              const SizedBox(height: 24),

              const Text(
                'Bible IA',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                '${AppStrings.version} $version',
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 40),

              Text(
                AppStrings.developedBy,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                company,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              const Text(
                'Breno R. Pantoja',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),

              const SizedBox(height: 40),

              InkWell(
                onTap: _openEmail,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.email_outlined,
                        color: Colors.blue,
                        size: 34,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'p.engenhariabrasil@gmail.com',
                        style: TextStyle(
                          fontSize: 17,
                          decoration:
                              TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              InkWell(
                onTap: _openWebsite,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.language,
                        color: Colors.blue,
                        size: 34,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'www.p.engenhariabrasil.com',
                        style: TextStyle(
                          fontSize: 17,
                          decoration:
                              TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 50),

              Text(
                '© 2026 $company',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}