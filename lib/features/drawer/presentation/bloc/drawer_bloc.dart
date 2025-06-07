import 'package:consumer/features/drawer/domain/entities/drawer_entity.dart';
import 'package:consumer/features/drawer/presentation/widgets/widgets.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(DrawerInitialState()) {
    on<SelectDrawerItem>((event, emit) {
      emit(DrawerItemSelected(event.selectedItem));
    });
  }
}
