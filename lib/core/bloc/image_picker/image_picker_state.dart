part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerState extends Equatable {}

final class ImagePickerInitial extends ImagePickerState {
  @override
  List<Object> get props => [];
}

final class ImagePickerLoading extends ImagePickerState {
  @override
  List<Object> get props => [];
}

final class ImagePickerSuccess extends ImagePickerState {
  final File file;

  ImagePickerSuccess({required this.file});

  @override
  List<Object> get props => [file];
}

final class ImagePickerFailure extends ImagePickerState {
  final String error;

  ImagePickerFailure({required this.error});

  @override
  List<Object> get props => [error];
}
