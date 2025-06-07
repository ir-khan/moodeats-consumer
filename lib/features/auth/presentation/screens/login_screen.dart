import 'package:consumer/core/enums/enums.dart';
import 'package:consumer/core/services/services.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/core/widgets/widgets.dart';
import 'package:consumer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:consumer/features/auth/presentation/widgets/widgets.dart';
import 'package:consumer/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                message: 'Login Successful',
                toastType: ToastType.success,
              );
              NavigationHelper.goToHome(context);
            } else if (state is AuthFailureState) {
              serviceLocator<ToastService>().show(
                message: state.error,
                toastType: ToastType.error,
              );
            }
          },
          builder: (context, state) {
            bool isPasswordLoginVisible = false;
            if (state is PasswordLoginVisibilityState) {
              isPasswordLoginVisible = state.isPasswordLoginVisible;
            }
            if (state is AuthLoadingState) {
              return CustomCircularProgressIndicator();
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 12,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      BrandLogo(),
                      CustomAuthHeading(text: 'Login'),
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
                        isPassword: !isPasswordLoginVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          // else if (!Validators.passwordRegex.hasMatch(
                          //   value,
                          // )) {
                          //   return 'Password must be at least 8 characters, include 1 letter, 1 number, and 1 special character (@\$!%*?&)';
                          // }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordLoginVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              TogglePasswordLoginVisibilityEvent(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              AuthLoginEvent(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                        text: 'Login',
                      ),
                      CustomRichText(
                        text: 'Don\'t have an account? ',
                        clickableText: 'Register',
                        onTap: () {
                          NavigationHelper.pushRegister(context);
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
