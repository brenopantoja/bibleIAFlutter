import 'package:biblia_ia/shared/data/%20drawer_items.dart';
import 'package:flutter/material.dart';

 
class DrawerItems {
  DrawerItems._();

  static const List<DrawerItem> items = [

    DrawerItem(
      title: 'Home',
      icon: Icons.home,
      route: '/home',
    ),

    DrawerItem(
      title: 'Ler Bíblia',
      icon: Icons.menu_book,
      route: '/bible',
    ),

    DrawerItem(
      title: 'Conversar com IA',
      icon: Icons.auto_awesome,
      route: '/ai-chat',
    ),

    DrawerItem(
      title: 'Pesquisa',
      icon: Icons.search,
      route: '/search',
    ),

    DrawerItem(
      title: 'Favoritos',
      icon: Icons.favorite,
      route: '/favorites',
    ),

    DrawerItem(
      title: 'Versículo do Dia',
      icon: Icons.today,
      route: '/verse-day',
    ),

    DrawerItem(
      title: 'Configurações',
      icon: Icons.settings,
      route: '/settings',
    ),

    DrawerItem(
      title: 'Idioma',
      icon: Icons.language,
      route: '/language',
    ),

    DrawerItem(
      title: 'Sobre',
      icon: Icons.info_outline,
      route: '/about',
    ),
  ];
}