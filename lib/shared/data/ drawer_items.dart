// ignore: file_names
import 'package:flutter/material.dart';

class DrawerItem {
  const DrawerItem({
    required this.title,
    required this.icon,
    required this.route,
  });

  final String title;

  final IconData icon;

  final String route;
}