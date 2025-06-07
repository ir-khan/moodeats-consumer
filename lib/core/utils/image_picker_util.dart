import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtil {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      return await _picker.pickImage(source: source);
    } catch (e) {
      debugPrint("Error picking image: $e");
      return null;
    }
  }

  Future<List<XFile>> pickMultipleImages() async {
    try {
      return await _picker.pickMultiImage();
    } catch (e) {
      debugPrint("Error picking multiple images: $e");
      return [];
    }
  }

  Future<CroppedFile?> cropImage({
    required XFile imageFile,
    CropAspectRatio? aspectRatio,
    bool circleCrop = false,
  }) async {
    try {
      return await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: aspectRatio ?? const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            // toolbarColor: Theme.of(context).colorScheme.primary,
            // toolbarWidgetColor: Theme.of(context).colorScheme.onPrimary,
            // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            // activeControlsWidgetColor: Theme.of(context).colorScheme.tertiary,
            // dimmedLayerColor: Theme.of(
            //   context,
            // ).colorScheme.primaryContainer.withAlpha(180),
            // cropFrameColor: Theme.of(context).colorScheme.secondary,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            cropStyle: CropStyle.circle,
          ),
          IOSUiSettings(
            title: 'Crop Image',
            doneButtonTitle: 'Done',
            cancelButtonTitle: 'Cancel',
            aspectRatioLockEnabled: false,
            rotateButtonsHidden: false,
            resetButtonHidden: false,
            cropStyle: CropStyle.circle,
          ),
        ],
      );
    } catch (e) {
      debugPrint("Error cropping image: $e");
      return null;
    }
  }
}
