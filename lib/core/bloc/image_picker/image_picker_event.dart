part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerEvent extends Equatable {}

final class PickImageEvent extends ImagePickerEvent {
  final ImageSource source;

  PickImageEvent({required this.source});

  @override
  List<Object> get props => [source];
}
