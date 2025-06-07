import 'dart:io';

import 'package:consumer/core/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtil imagePickerUtil;

  ImagePickerBloc(this.imagePickerUtil) : super(ImagePickerInitial()) {
    on<PickImageEvent>(_onPickImage);
  }

  Future<void> _onPickImage(
    PickImageEvent event,
    Emitter<ImagePickerState> emit,
  ) async {
    emit(ImagePickerLoading());

    final XFile? file = await imagePickerUtil.pickImage(event.source);

    if (file != null) {
      final croppedFile = await imagePickerUtil.cropImage(imageFile: file);
      if (croppedFile != null) {
        emit(ImagePickerSuccess(file: File(croppedFile.path)));
      }
    } else {
      emit(ImagePickerFailure(error: "Failed to pick image"));
    }
  }
}
