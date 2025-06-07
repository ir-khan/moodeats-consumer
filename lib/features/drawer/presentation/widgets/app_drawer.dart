import 'package:consumer/config/routes/routes_path.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/auth/auth.dart';
import 'package:consumer/features/drawer/domain/entities/drawer_entity.dart';
import 'package:consumer/features/drawer/presentation/bloc/drawer_bloc.dart';
import 'package:consumer/features/drawer/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static final List<DrawerItem> drawerItems = [
    DrawerItem(
      title: RoutesName.home,
      route: RoutesPath.home,
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    DrawerItem(
      title: RoutesName.profile,
      route: RoutesPath.profile,
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
    ),
    // DrawerItem(
    //   title: 'Settings',
    //   route: '/settings',
    //   icon: Icons.settings_outlined,
    //   selectedIcon: Icons.settings,
    // ),
    DrawerItem(
      title: 'Logout',
      route: '',
      icon: Icons.logout_rounded,
      selectedIcon: Icons.logout,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: MediaQuery.of(context).size.width * 0.55,
      child: Column(
        spacing: 10,
        children: [
          CustomDrawerHearder(),
          BlocBuilder<DrawerBloc, DrawerState>(
            builder: (context, state) {
              return Column(
                children:
                    drawerItems.map((item) {
                      bool isSelected = item.route == state.selectedItem.route;
                      return CustomDrawerItem(
                        title: item.title,
                        icon:
                            isSelected
                                ? item.selectedIcon ?? item.icon
                                : item.icon,
                        isSelected: isSelected,
                        onTap: () {
                          if (item.title == 'Logout') {
                            context.read<AuthBloc>().add(AuthLogoutEvent());
                          } else {
                            context.read<DrawerBloc>().add(
                              SelectDrawerItem(selectedItem: item),
                            );
                            Navigator.of(context).pop();
                            NavigationHelper.push(context, item.route);
                          }
                        },
                      );
                    }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
