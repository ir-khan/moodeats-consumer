import 'dart:io';

import 'package:consumer/config/routes/routes_args.dart';
import 'package:consumer/core/enums/enums.dart';
import 'package:consumer/core/services/services.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/core/widgets/widgets.dart';
import 'package:consumer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:consumer/features/auth/presentation/widgets/widgets.dart';
import 'package:consumer/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final PhoneController _numberController = PhoneController(
    initialValue: PhoneNumber(isoCode: IsoCode.PK, nsn: ''),
  );

  final _formKey = GlobalKey<FormState>();

  File? _avatar;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticatedState) {
              serviceLocator<ToastService>().show(
                message: 'Register Successful',
                toastType: ToastType.success,
              );
              NavigationHelper.goToOtp(
                context,
                extra:
                    OtpArgs(
                      phone: _numberController.value.international.trim(),
                      fromRegister: true,
                    ).toJsonString(),
              );
            } else if (state is AuthFailureState) {
              serviceLocator<ToastService>().show(
                message: state.error,
                toastType: ToastType.error,
              );
            }
          },
          builder: (context, state) {
            bool isPasswordRegisterVisible = false;
            if (state is PasswordRegisterVisibilityState) {
              isPasswordRegisterVisible = state.isPasswordRegisterVisible;
            }
            if (state is AuthLoadingState) {
              return CustomCircularProgressIndicator();
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 12,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      // BrandLogo(),
                      CustomAuthHeading(text: 'Create a new account'),
                      AvatarWidget(
                        radius: MediaQuery.of(context).size.width * 0.15,
                        onImageSelected: (File? image) {
                          _avatar = image;
                        },
                      ),
                      CustomInputField(
                        label: 'Full Name',
                        icon: Icons.person_rounded,
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          } else if (!Validators.nameRegex.hasMatch(value)) {
                            return 'Enter a valid name (2-50 letters and spaces only)';
                          }
                          return null;
                        },
                      ),
                      CustomInputField(
                        label: 'Email',
                        icon: Icons.email_rounded,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!Validators.emailRegex.hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      CustomInputField(
                        label: 'Password',
                        icon: Icons.lock_rounded,
                        controller: _passwordController,
                        isPassword: !isPasswordRegisterVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (!Validators.passwordRegex.hasMatch(
                            value,
                          )) {
                            return 'Password must be at least 8 characters, include 1 letter, 1 number, and 1 special character (@\$!%*?&)';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordRegisterVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              TogglePasswordRegisterVisibilityEvent(),
                            );
                          },
                        ),
                      ),
                      CustomInputField(
                        label: 'Confirm Password',
                        icon: Icons.lock_rounded,
                        controller: _confirmPasswordController,
                        isPassword: !isPasswordRegisterVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordRegisterVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              TogglePasswordRegisterVisibilityEvent(),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: PhoneFormField(
                          controller: _numberController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                          ),
                          validator: (phone) {
                            if (phone == null || phone.nsn.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (!Validators.phoneNumberRegex.hasMatch(
                              phone.nsn,
                            )) {
                              return 'Enter a valid phone number (10-15 digits)';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Dispatch a RegisterEvent including avatar, if needed.
                            context.read<AuthBloc>().add(
                              AuthRegisterEvent(
                                name: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                phone:
                                    _numberController.value.international
                                        .trim(),
                                avatar: _avatar,
                              ),
                            );
                          }
                        },
                        text: 'Register',
                      ),
                      CustomRichText(
                        text: 'Already have an account? ',
                        clickableText: 'Login',
                        onTap: () {
                          NavigationHelper.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
