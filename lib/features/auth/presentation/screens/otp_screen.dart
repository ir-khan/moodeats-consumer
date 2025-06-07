import 'package:consumer/core/enums/enums.dart';
import 'package:consumer/core/services/services.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/core/widgets/widgets.dart';
import 'package:consumer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:consumer/features/auth/presentation/widgets/widgets.dart';
import 'package:consumer/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phone, required this.fromRegister});

  final String phone;
  final bool fromRegister;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isError = false;

  @override
  void initState() {
    context.read<AuthBloc>().add(AuthRequestOtpEvent(phone: widget.phone));
    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            _isError = false;
            serviceLocator<ToastService>().show(
              message: "OTP Verified!",
              toastType: ToastType.success,
            );
            if (widget.fromRegister) {
              NavigationHelper.goToLogin(context);
            } else {
              NavigationHelper.goToProfile(context);
            }
          } else if (state is AuthFailureState) {
            _isError = true;
            serviceLocator<ToastService>().show(
              message: state.error,
              toastType: ToastType.error,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 25,
              children: [
                Text(
                  "Verify your phone number",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "We've sent an SMS with an OTP\nto your phone ${widget.phone}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: CustomPinputField(
                    controller: _otpController,
                    isError: _isError,
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  onPressed:
                      state is AuthLoadingState
                          ? null
                          : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                AuthVerifyOtpEvent(
                                  phone: widget.phone,
                                  otp: _otpController.text.trim(),
                                ),
                              );
                            }
                          },
                  text: "Verify",
                ),
                const SizedBox(height: 10),
                state is AuthResendOtpDisabledState
                    ? Text(
                      "Send code again in ${state.remainingTime}s",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).disabledColor,
                      ),
                    )
                    : CustomRichText(
                      text: "Didn't get a code? ",
                      clickableText: "Resend",
                      onTap:
                          () => context.read<AuthBloc>().add(
                            AuthResendOtpEvent(phone: widget.phone),
                          ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
