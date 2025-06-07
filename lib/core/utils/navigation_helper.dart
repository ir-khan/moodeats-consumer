import 'package:consumer/config/routes/routes_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationHelper {
  static void go(BuildContext context, String path, {Object? extra}) {
    context.go(path, extra: extra);
  }

  static void push(BuildContext context, String path, {Object? extra}) {
    final router = GoRouter.of(context);
    final matches = router.routerDelegate.currentConfiguration.matches;

    // Check if the desired path is already in the navigation stack
    final existingMatchIndex = matches.indexWhere(
      (match) => match.matchedLocation == path,
    );

    // If it's at the top, replace it
    if (matches.isNotEmpty && matches.last.matchedLocation == path) {
      router.replace(path, extra: extra);
      return;
    }

    // If it's in the stack but not at the top, pop until we get there
    if (existingMatchIndex != -1) {
      final popCount = matches.length - existingMatchIndex - 1;
      for (int i = 0; i < popCount; i++) {
        router.pop();
      }
      return;
    }

    // Otherwise push it
    router.push(path, extra: extra);
  }

  static void goToRegister(BuildContext context) {
    context.go(RoutesPath.register);
  }

  static void pushRegister(BuildContext context) {
    context.push(RoutesPath.register);
  }

  static void goToLogin(BuildContext context) {
    context.go(RoutesPath.login);
  }

  static void pushLogin(BuildContext context) {
    context.push(RoutesPath.login);
  }

  static void goToOtp(BuildContext context, {Object? extra}) {
    context.go(RoutesPath.otp, extra: extra);
  }

  static void pushOtp(BuildContext context, {Object? extra}) {
    context.push(RoutesPath.otp, extra: extra);
  }

  static void goToHome(BuildContext context) {
    context.go(RoutesPath.home);
  }

  static void pushHome(BuildContext context) {
    context.push(RoutesPath.home);
  }

  static void goToProfile(BuildContext context) {
    context.go(RoutesPath.profile);
  }

  static void pushAccountDetails(BuildContext context) {
    context.push(RoutesPath.accountDetails);
  }

  // static void goToMoodInput(BuildContext context) {
  //   context.go(RoutesPath.moodInput);
  // }

  static void pushMoodInput(BuildContext context) {
    context.push(RoutesPath.moodInput);
  }

  static void pushPaginatedFood(BuildContext context, {Object? extra}) {
    context.push(RoutesPath.foods, extra: extra);
  }

  static void pushFoodDetails(BuildContext context, {Object? extra}) {
    context.push(RoutesPath.foodDetails, extra: extra);
  }

  static void pop(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }
}
