import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/core/widgets/widgets.dart';
import 'package:consumer/features/auth/auth.dart';
import 'package:consumer/features/drawer/drawer.dart';
import 'package:consumer/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:consumer/features/profile/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                spacing: 20,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  AvatarWidget(
                    networkImage: state.user.avatar,
                    radius: 60,
                    onImageSelected: (image) {
                      if (image != null) {
                        context.read<ProfileBloc>().add(
                          UpdateAvatarEvent(avatar: image),
                        );
                      }
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Account Details',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    titleAlignment: ListTileTitleAlignment.center,
                    contentPadding: EdgeInsets.symmetric(horizontal: 4),
                    trailing: GestureDetector(
                      onTap: () => NavigationHelper.pushAccountDetails(context),
                      child: Icon(Icons.arrow_forward_ios_sharp, size: 25),
                    ),
                  ),
                  CustomButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogoutEvent());
                    },
                    text: 'Logout',
                  ),
                ],
              ),
            );
          }
          return ProfileShimmerWidget();
        },
      ),
    );
  }
}
