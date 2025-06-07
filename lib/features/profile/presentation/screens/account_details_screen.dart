import 'package:consumer/config/routes/routes_args.dart';
import 'package:consumer/core/domain/entities/user.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/core/widgets/widgets.dart';
import 'package:consumer/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:consumer/features/profile/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  UserEntity? _currentUser;

  void _onSave() {
    final newName = _nameController.text.trim();
    final newPhone = _phoneController.text.trim();

    if (_currentUser == null) return;

    bool isPhoneChanged = newPhone != _currentUser!.phone;

    context.read<ProfileBloc>().add(
      UpdateProfileEvent(name: newName, phone: newPhone),
    );

    if (isPhoneChanged) {
      NavigationHelper.pushOtp(
        context,
        extra: OtpArgs(phone: newPhone, fromRegister: false).toJsonString(),
      );
    }
    isPhoneChanged = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Details',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              final user = state.user;
              _currentUser = user;

              _nameController.text = user.name;
              _phoneController.text = user.phone;

              return Column(
                spacing: 40,
                children: [
                  SizedBox(),
                  ProfileSectionCard(
                    title: 'Public Info',
                    children: [
                      ProfileField(
                        label: 'Name',
                        valueWidget: TextField(
                          controller: _nameController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Name',
                          ),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  ProfileSectionCard(
                    title: 'Private Details',
                    children: [
                      ProfileField(
                        label: 'Email',
                        valueWidget: Text(
                          user.email,
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      ProfileField(
                        label: 'Phone',
                        valueWidget: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Name',
                          ),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  CustomButton(onPressed: _onSave, text: 'Save'),
                ],
              );
            }
            return AccountDetailsShimmerWidget();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
