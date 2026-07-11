import 'package:biblia_ia/core/localization/app_strings.dart';
import 'package:biblia_ia/shared/data/%20drawer_items.dart';
 
import 'package:flutter/material.dart';

class DrawerItems {
  DrawerItems._();

  static List<DrawerItem> get items => [

        DrawerItem(
          title: AppStrings.home,
          icon: Icons.home,
          route: '/home',
        ),

        DrawerItem(
          title: AppStrings.readBible,
          icon: Icons.menu_book,
          route: '/bible',
        ),

        DrawerItem(
          title: AppStrings.aiChat,
          icon: Icons.auto_awesome,
          route: '/ai-chat',
        ),

        DrawerItem(
          title: AppStrings.search,
          icon: Icons.search,
          route: '/search',
        ),

        DrawerItem(
          title: AppStrings.favorites,
          icon: Icons.favorite,
          route: '/favorites',
        ),

        DrawerItem(
          title: AppStrings.verseOfDay,
          icon: Icons.today,
          route: '/verse-day',
        ),

        DrawerItem(
          title: AppStrings.settings,
          icon: Icons.settings,
          route: '/settings',
        ),

        DrawerItem(
          title: AppStrings.language,
          icon: Icons.language,
          route: '/language',
        ),

        DrawerItem(
          title: AppStrings.about,
          icon: Icons.info_outline,
          route: '/about',
        ),
      ];
}