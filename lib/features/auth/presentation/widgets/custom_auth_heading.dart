import 'package:flutter/material.dart';

class CustomAuthHeading extends StatelessWidget {
  final String text;

  const CustomAuthHeading({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w700,
          height: 2,
        ),
      ),
    );
  }
}
