part of 'drawer_bloc.dart';

@immutable
sealed class DrawerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SelectDrawerItem extends DrawerEvent {
  final DrawerItem selectedItem;

  SelectDrawerItem({required this.selectedItem});

  @override
  List<Object?> get props => [selectedItem];
}
