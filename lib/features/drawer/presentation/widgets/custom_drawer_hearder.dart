import 'package:cached_network_image/cached_network_image.dart';
import 'package:consumer/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CustomDrawerHearder extends StatelessWidget {
  const CustomDrawerHearder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final user = state.user;
          return UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(user.avatar),
            ),
            accountName: Text(user.name),
            accountEmail: Text(user.email),
          );
        }
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey.shade400,
            ),
            accountName: Container(width: 100, height: 16, color: Colors.grey),
            accountEmail: Container(width: 150, height: 14, color: Colors.grey),
          ),
        );
      },
    );
  }
}
