part of 'drawer_bloc.dart';

@immutable
sealed class DrawerState extends Equatable {
  final DrawerItem selectedItem;
  const DrawerState(this.selectedItem);

  @override
  List<Object?> get props => [selectedItem];
}

final class DrawerInitialState extends DrawerState {
  DrawerInitialState()
    : super(AppDrawer.drawerItems[0]);
}

final class DrawerItemSelected extends DrawerState {
  const DrawerItemSelected(super.selectedItem);
}
