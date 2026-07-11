import 'package:biblia_ia/core/localization/app_strings.dart';
import 'package:biblia_ia/core/providers/bible_provider.dart';
import 'package:biblia_ia/core/routes/app_routes.dart';
import 'package:biblia_ia/features/bible/controllers/language_controller.dart';
import 'package:biblia_ia/features/search/pages/search_page.dart';
import 'package:biblia_ia/shared/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

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

  Set<String> selectedLanguage = {'pt'};
  
  @override
  void initState() {
    super.initState();

    controller = HomeController(
      HomeRepository(),
    );

    _load();
  }

  Future<void> _load() async {
    await controller.loadHealth();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      drawer: AppDrawer(
        version: controller.version,
      ),

      appBar: AppBar(
        title: const Text(
          'Bible IA',
        ),
      ),

      bottomNavigationBar:
          BackendStatusWidget(
        online: controller.backendOnline,
        applicationName:
            controller.applicationName,
        version: controller.version,
      ),

      body: SafeArea(

        child: ListView(

          padding:
              const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),

          children: [

            //--------------------------------
            // Logo
            //--------------------------------

            Center(
              child: Image.asset(
                'assets/icons/app_icon.png',
                width: 140,
                height: 140,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            Text(
              AppStrings.welcome,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            Text(
              AppStrings.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            //--------------------------------
            // Pesquisa
            //--------------------------------

            Material(
              color: Colors.transparent,

              child: InkWell(

                borderRadius:
                    BorderRadius.circular(
                  18,
                ),

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) => SearchPage(
                        books: BibleProvider.instance.books,
                      ),

                    ),

                  );

                },

                child: Container(

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),

                  decoration:
                      BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),

                    border: Border.all(
                      color:
                          Colors.grey.shade300,
                    ),

                    boxShadow: const [

                      BoxShadow(

                        color:
                            Colors.black12,

                        blurRadius: 8,

                        offset:
                            Offset(0, 2),

                      ),

                    ],

                  ),

                  child: Row(

                    children: [

                      Icon(Icons.search),

                      SizedBox(
                        width: 12,
                      ),

                      Expanded(

                        child: Text(
                          AppStrings.search,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),

                      ),

                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color:
                            Colors.grey,
                      ),

                    ],

                  ),

                ),

              ),

            ),

            const SizedBox(
              height: 20,
            ),

            //--------------------------------
            // IA
            //--------------------------------

            SizedBox(

              height: 55,

              child: ElevatedButton.icon(

                onPressed: () {},

                icon: const Icon(
                  Icons.auto_awesome,
                ),

                label: Text(
                  AppStrings.askAI,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

              ),

            ),

            const SizedBox(
              height: 25,
            ),

            //--------------------------------
            // Idioma
            //--------------------------------

            Center(

              child: SegmentedButton<
                  String>(

                segments: const [

                  ButtonSegment(
                    value: 'pt',
                    label:
                        Text('Português'),
                  ),

                  ButtonSegment(
                    value: 'en',
                    label:
                        Text('English'),
                  ),

                ],

                selected:
                    selectedLanguage,

                onSelectionChanged:
                    (value) async {

                  setState(() {
                    selectedLanguage =
                        value;
                  });

                  final english =
                      value.first == 'en';

                  await languageController
                      .changeLanguage(
                    english,
                  );

                  if (!mounted) {
                    return;
                  }

                  setState(() {});

                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(

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
 
            //--------------------------------
            // Acesso rápido
            //--------------------------------
 
 

          const SizedBox(
          height: 40,
        ),

 
Text(
  AppStrings.quickAccess,
  style: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(
  height: 18,
),

//--------------------------------
// Ler Bíblia
//--------------------------------

Card(
  child: ListTile(
    leading: const Icon(
      Icons.menu_book,
    ),
    title: Text(
      AppStrings.readBible,
    ),
    subtitle: Text(
      AppStrings.readBibleSubtitle,
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios,
    ),
    onTap: () {
      Navigator.pushNamed(
        context,
        AppRoutes.books,
      );
    },
  ),
),

const SizedBox(
  height: 10,
),

//--------------------------------
// Conversar com IA
//--------------------------------

Card(
  child: ListTile(
    leading: const Icon(
      Icons.auto_awesome,
    ),
    title: Text(
      AppStrings.aiChat,
    ),
    subtitle: Text(
      AppStrings.aiChatSubtitle,
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios,
    ),
    onTap: () {},
  ),
),

const SizedBox(
  height: 10,
),

//--------------------------------
// Favoritos
//--------------------------------

Card(
  child: ListTile(
    leading: const Icon(
      Icons.favorite,
    ),
    title: Text(
      AppStrings.favorites,
    ),
    subtitle: Text(
      AppStrings.favoritesSubtitle,
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios,
    ),
    onTap: () {},
  ),
),

const SizedBox(
  height: 10,
),

//--------------------------------
// Versículo do Dia
//--------------------------------

Card(
  child: ListTile(
    leading: const Icon(
      Icons.today,
    ),
    title: Text(
      AppStrings.verseOfDay,
    ),
    subtitle: Text(
      AppStrings.verseOfDaySubtitle,
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios,
    ),
    onTap: () {},
  ),
),

const SizedBox(
  height: 40,
),
            const SizedBox(
              height: 40,
            ),

          ],

        ),

      ),

    );
  }
}