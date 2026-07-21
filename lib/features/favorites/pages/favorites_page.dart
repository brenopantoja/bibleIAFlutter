import 'package:bibliaia/core/localization/app_strings.dart';
import 'package:flutter/material.dart';

import '../controllers/favorite_controller.dart';
import '../models/favorite_verse.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({
    super.key,
  });

  @override
  State<FavoritesPage> createState() =>
      _FavoritesPageState();
}

class _FavoritesPageState
    extends State<FavoritesPage> {

  late final FavoriteController controller;

  @override
  void initState() {
    super.initState();

    controller = FavoriteController();

    controller.addListener(_refresh);

    controller.loadFavorites();
  }

  void _refresh() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_refresh);

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(
          AppStrings.favorites,
        ),

        centerTitle: true,

      ),

      body: Builder(

        builder: (_) {

          if (controller.loading) {

            return const Center(
              child: CircularProgressIndicator(),
            );

          }

          if (controller.favorites.isEmpty) {

            return Center(
              child: Text(
                AppStrings.noFavorites,
              ),
            );

          }

          return Column(
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                16,
                20,
                8,
              ),
              child: Row(
                children: [

                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),

                  const SizedBox(width: 8),

                  Text(
                    '${controller.total} '
                    '${controller.total == 1 ? (AppStrings.english ? "favorite" : "favorito") : (AppStrings.english ? "favorites" : "favoritos")}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.favorites.length,
                itemBuilder: (context, index) {

                  final verse =
                      controller.favorites[index];

                  return _FavoriteCard(
                    verse: verse,
                    controller: controller,
                  );

                },
              ),
            ),

          ],
        );

        },

      ),

    );

  }

}

class _FavoriteCard extends StatelessWidget {

  final FavoriteVerse verse;

  final FavoriteController controller;

  const _FavoriteCard({

    required this.verse,

    required this.controller,

  });

  @override
  Widget build(BuildContext context) {

    return Card(

      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      child: Padding(

        padding:
            const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Row(

              children: [

                Expanded(

                  child: Text(

                    verse.reference,

                    style:
                        const TextStyle(

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),

                ),

                IconButton(

                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),

                  onPressed: () async {

                    await controller.remove(
                      verse,
                    );

                  },

                ),

              ],

            ),

            const SizedBox(
              height: 10,
            ),

            SelectableText(

              verse.text,

              style:
                  const TextStyle(

                fontSize: 16,

                height: 1.5,

              ),

            ),

            const SizedBox(
              height: 16,
            ),

            Text(

              verse.language == 'en'
                  ? 'English'
                  : 'Português',

              style: TextStyle(

                color: Colors.grey.shade600,

              ),

            ),
          ],
        ),
      ),
    );
  }
}