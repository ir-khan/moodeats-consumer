import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final String route;
  final IconData icon;
  final IconData? selectedIcon;

  const DrawerItem({
    required this.title,
    required this.route,
    required this.icon,
    this.selectedIcon
  });

  @override
  String toString() {
    return 'DrawerItem(title: $title, route: $route, icon: $icon)';
  }
}
