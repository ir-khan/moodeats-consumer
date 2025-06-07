import 'package:consumer/features/food/food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:consumer/config/routes/app_route_observer.dart';
import 'package:consumer/config/routes/routes_args.dart';
import 'package:consumer/config/routes/routes_path.dart';
import 'package:consumer/core/constants/storage_keys.dart';
import 'package:consumer/core/utils/stream_to_listenable.dart';
import 'package:consumer/features/auth/auth.dart';
import 'package:consumer/features/drawer/drawer.dart';
import 'package:consumer/features/home/home.dart';
import 'package:consumer/features/mood_based_recommendation/mood_based_recommendation.dart';
import 'package:consumer/features/onboarding/onboarding.dart';
import 'package:consumer/features/profile/profile.dart';
import 'package:consumer/init_dependencies.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

  static bool hasSeenOnboarding = false;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: RoutesPath.login,
    routerNeglect: true,
    refreshListenable: StreamToListenable([serviceLocator<AuthBloc>().stream]),
    observers: [AppRouteObserver(serviceLocator<DrawerBloc>())],
    redirect: _handleRedirect,
    routes: _getRoutes(),
  );

  static Future<void> preloadFlags() async {
    final storage = serviceLocator<FlutterSecureStorage>();
    final seen = await storage.read(key: StorageKeys.hasSeenOnboarding);

    hasSeenOnboarding = seen == 'true';
  }

  static String? _handleRedirect(BuildContext context, GoRouterState state) {
    final authState = serviceLocator<AuthBloc>().state;

    // 1. Wait if auth state is not determined
    if (authState is AuthLoadingState) return null;

    // 2. Redirect to onboarding if needed
    if (!hasSeenOnboarding && state.fullPath != RoutesPath.onboarding) {
      return RoutesPath.onboarding;
    }

    // 3. Authenticated logic
    if (authState is AuthAuthenticatedState) {
      if (state.fullPath == RoutesPath.login ||
          state.fullPath == RoutesPath.register ||
          state.fullPath == RoutesPath.onboarding) {
        return RoutesPath.home;
      }
    }

    // 4. Unauthenticated logic
    if (authState is AuthUnAuthenticatedState) {
      if (state.fullPath != RoutesPath.login &&
          state.fullPath != RoutesPath.register &&
          state.fullPath != RoutesPath.onboarding) {
        return RoutesPath.login;
      }
    }

    return null;
  }

  static List<GoRoute> _getRoutes() => [
    GoRoute(
      path: RoutesPath.onboarding,
      name: RoutesName.onboarding,
      pageBuilder:
          (context, state) => const MaterialPage(
            child: OnboardingScreen(),
            name: RoutesName.onboarding,
          ),
    ),
    GoRoute(
      path: RoutesPath.login,
      name: RoutesName.login,
      pageBuilder:
          (context, state) =>
              const MaterialPage(child: LoginScreen(), name: RoutesName.login),
    ),
    GoRoute(
      path: RoutesPath.register,
      name: RoutesName.register,
      pageBuilder:
          (context, state) => const MaterialPage(
            child: RegisterScreen(),
            name: RoutesName.register,
          ),
    ),
    GoRoute(
      path: RoutesPath.otp,
      name: RoutesName.otp,
      pageBuilder: (context, state) {
        final otpArgs = OtpArgs.fromJsonString(state.extra as String);
        return MaterialPage(
          child: OtpScreen(
            phone: otpArgs.phone,
            fromRegister: otpArgs.fromRegister,
          ),
          name: RoutesName.otp,
        );
      },
    ),
    GoRoute(
      path: RoutesPath.home,
      name: RoutesName.home,
      pageBuilder:
          (context, state) =>
              const MaterialPage(child: HomeScreen(), name: RoutesName.home),
    ),
    GoRoute(
      path: RoutesPath.profile,
      name: RoutesName.profile,
      pageBuilder:
          (context, state) => const MaterialPage(
            child: ProfileScreen(),
            name: RoutesName.profile,
          ),
    ),
    GoRoute(
      path: RoutesPath.accountDetails,
      name: RoutesName.accountDetails,
      pageBuilder:
          (context, state) => const MaterialPage(
            child: AccountDetailsScreen(),
            name: RoutesName.accountDetails,
          ),
    ),
    GoRoute(
      path: RoutesPath.moodInput,
      name: RoutesName.moodInput,
      pageBuilder:
          (context, state) => const MaterialPage(
            child: MoodInputScreen(),
            name: RoutesName.moodInput,
          ),
    ),
    GoRoute(
      path: RoutesPath.foods,
      name: RoutesName.foods,
      pageBuilder: (context, state) {
        final moodTags = state.extra as List<String>;
        return MaterialPage(
          child: PaginatedFoodScreen(moodTags: moodTags),
          name: RoutesName.foods,
        );
      },
    ),
    GoRoute(
      path: RoutesPath.foodDetails,
      name: RoutesName.foodDetails,
      pageBuilder: (context, state) {
        final food = state.extra as FoodEntity;
        return MaterialPage(
          child: FoodDetailsScreen(food: food),
          name: RoutesName.foodDetails,
        );
      },
    ),
  ];

  static GoRouter get router => _router;
}

// import 'package:consumer/config/routes/routes_path.dart';
// import 'package:consumer/core/utils/stream_to_listenable.dart';
// import 'package:consumer/features/auth/auth.dart';
// import 'package:consumer/features/home/home.dart';
// import 'package:consumer/features/onboarding/onboarding.dart';
// import 'package:consumer/features/profile/profile.dart';
// import 'package:consumer/init_dependencies.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:go_router/go_router.dart';

// class AppRouter {
//   static final _rootNavigatorKey = GlobalKey<NavigatorState>();

//   static final GoRouter _router = GoRouter(
//     navigatorKey: _rootNavigatorKey,
//     debugLogDiagnostics: true,
//     routerNeglect: true,
//     overridePlatformDefaultLocation: true,
//     initialLocation: RoutesPath.login,
//     refreshListenable: StreamToListenable([serviceLocator<AuthBloc>().stream]),
//     redirect: (context, state) async => await _handleRedirect(state),
//     routes: _getRoutes(),
//   );

//   static Future<String?> _handleRedirect(GoRouterState state) async {
//     print(
//       "From AppRoute  1. ${state.fullPath}  2. ${serviceLocator<AuthBloc>().state}",
//     );
//     final hasSeenOnboarding = await _checkOnboardingStatus();
//     if (!hasSeenOnboarding) return RoutesPath.onboarding;

//     return _handleAuthRedirect(state);
//   }

//   static Future<bool> _checkOnboardingStatus() async {
//     final storage = serviceLocator<FlutterSecureStorage>();
//     final seenOnboarding = await storage.read(key: 'has_seen_onboarding');
//     return seenOnboarding == 'true';
//   }

//   static String? _handleAuthRedirect(GoRouterState state) {
//     final authState = serviceLocator<AuthBloc>().state;
//     if (authState is AuthAuthenticatedState) {
//       return state.fullPath == RoutesPath.home ? RoutesPath.home : null;
//     }
//     if (authState is AuthUnAuthenticatedState) {
//       return state.fullPath == RoutesPath.home ? RoutesPath.login : null;
//     }
//     return null;
//   }

//   static List<GoRoute> _getRoutes() => [
//     GoRoute(
//       path: RoutesPath.onboarding,
//       pageBuilder: (context, state) => MaterialPage(child: OnboardingScreen()),
//     ),
//     GoRoute(
//       path: RoutesPath.login,
//       pageBuilder: (context, state) => MaterialPage(child: LoginScreen()),
//     ),
//     GoRoute(
//       path: RoutesPath.register,
//       pageBuilder: (context, state) => MaterialPage(child: RegisterScreen()),
//     ),
//     GoRoute(
//       path: RoutesPath.otp,
//       pageBuilder: (context, state) {
//         final extra = state.extra as Map<String, dynamic>;
//         final phone = extra['phone'] as String;
//         final fromRegister = extra['fromRegister'] as bool;
//         return MaterialPage(
//           child: OtpScreen(phone: phone, fromRegister: fromRegister),
//         );
//       },
//     ),
//     GoRoute(
//       path: RoutesPath.home,
//       pageBuilder: (context, state) => MaterialPage(child: HomeScreen()),
//     ),
//     GoRoute(
//       path: RoutesPath.profile,
//       pageBuilder: (context, state) => MaterialPage(child: ProfileScreen()),
//     ),
//     GoRoute(
//       path: RoutesPath.accountDetails,
//       pageBuilder:
//           (context, state) => MaterialPage(child: AccountDetailsScreen()),
//     ),
//   ];

//   static GoRouter get router => _router;
// }
