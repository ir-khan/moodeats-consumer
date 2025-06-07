import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ProgressIndicatorTheme(
        data: ProgressIndicatorThemeData(
          color: Theme.of(context).colorScheme.primary,
          circularTrackColor: Theme.of(
            context,
          ).colorScheme.primary.brighten(50),
          strokeWidth: 4,
          strokeAlign: 1,
          strokeCap: StrokeCap.round,
          constraints: const BoxConstraints(
            maxHeight: 40,
            maxWidth: 40,
            minWidth: 30,
            minHeight: 30,
          ),
        ),
        child: const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class CustomLinearProgressIndicator extends StatelessWidget {
  const CustomLinearProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return ProgressIndicatorTheme(
      data: ProgressIndicatorThemeData(
        color: Theme.of(context).colorScheme.primary,
        linearTrackColor: Theme.of(context).colorScheme.primary.brighten(50),
        linearMinHeight: 5.5,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: LinearProgressIndicator(),
      ),
    );
  }
}
