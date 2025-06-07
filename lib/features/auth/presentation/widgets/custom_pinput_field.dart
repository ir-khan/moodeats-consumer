import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class CustomPinputField extends StatelessWidget {
  const CustomPinputField({
    super.key,
    required this.controller,
    this.isError = false,
  });

  final TextEditingController controller;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      length: 6,
      autofocus: true,
      keyboardType: TextInputType.number,
      crossAxisAlignment: CrossAxisAlignment.center,
      defaultPinTheme: _buildPinTheme(
        context,
        borderColor: Theme.of(context).colorScheme.secondary,
      ),
      focusedPinTheme: _buildPinTheme(
        context,
        borderColor: Theme.of(context).colorScheme.primary,
        textColor: Theme.of(context).colorScheme.primary,
        borderWidth: 1.25,
      ),
      submittedPinTheme: _buildPinTheme(
        context,
        borderColor: Theme.of(context).colorScheme.secondary,
      ),
      errorPinTheme: _buildPinTheme(
        context,
        borderColor: Theme.of(context).colorScheme.error,
        textColor: Theme.of(context).colorScheme.error,
        borderWidth: 1.25,
      ),
      validator: (value) {
        if (value == null || value.length < 6) {
          return 'Enter a valid 6-digit OTP';
        }
        return null;
      },
      errorText: isError ? 'Invalid OTP. Please try again.' : null,
      errorTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.error,
      ),
      forceErrorState: isError,
    );
  }

  PinTheme _buildPinTheme(
    BuildContext context, {
    required Color borderColor,
    Color? textColor,
    double borderWidth = 1,
  }) {
    return PinTheme(
      width: 40,
      height: 45,
      // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: textColor ?? Theme.of(context).colorScheme.secondary,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(7.5),
      ),
    );
  }
}
