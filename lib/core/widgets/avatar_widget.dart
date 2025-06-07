import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:consumer/core/bloc/image_picker/image_picker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AvatarWidget extends StatelessWidget {
  final String networkImage;
  final Function(File?) onImageSelected;
  final double radius;

  const AvatarWidget({
    super.key,
    required this.onImageSelected,
    this.radius = 50,
    this.networkImage =
        "https://res.cloudinary.com/izn-cloudinary/image/upload/v1741510874/s2ivd2jgkd5jzx0gvtkd.png",
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagePickerBloc, ImagePickerState>(
      listener: (context, state) {
        if (state is ImagePickerSuccess) {
          onImageSelected(state.file);
        }
      },
      builder: (context, state) {
        File? image;
        if (state is ImagePickerSuccess) {
          image = state.file;
        }
        return Stack(
          children: [
            CircleAvatar(
              radius: radius,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.tertiary.withAlpha(140),
              backgroundImage:
                  image != null
                      ? FileImage(image)
                      : CachedNetworkImageProvider(networkImage),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap:
                    () => context.read<ImagePickerBloc>().add(
                      PickImageEvent(source: ImageSource.gallery),
                    ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: radius * 0.35,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
