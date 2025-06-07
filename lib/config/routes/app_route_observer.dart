import 'package:flutter/material.dart';
import 'package:consumer/features/drawer/drawer.dart';

class AppRouteObserver extends NavigatorObserver {
  final DrawerBloc drawerBloc;

  AppRouteObserver(this.drawerBloc);

  @override
  void didPop(Route route, Route? previousRoute) {
    _updateSelectedItem(previousRoute?.settings.name);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _updateSelectedItem(route.settings.name);
  }

  void _updateSelectedItem(String? routeName) {
    final item = _findDrawerItem(routeName);
    if (item != null) {
      drawerBloc.add(SelectDrawerItem(selectedItem: item));
    }
  }

  DrawerItem? _findDrawerItem(String? routeName) {
    if (routeName == null) return null;
    try {
      return AppDrawer.drawerItems.firstWhere(
        (item) => item.title == routeName,
      );
    } catch (e) {
      return null;
    }
  }
}
