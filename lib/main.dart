import 'package:consumer/config/routes/app_router.dart';
import 'package:consumer/config/theme/theme.dart';
import 'package:consumer/core/bloc/blocs.dart';
import 'package:consumer/features/auth/auth.dart';
import 'package:consumer/features/drawer/drawer.dart';
import 'package:consumer/features/food/food.dart';
import 'package:consumer/features/mood_based_recommendation/mood_based_recommendation.dart';
import 'package:consumer/features/onboarding/onboarding.dart';
import 'package:consumer/features/profile/profile.dart';
import 'package:consumer/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await initialize();
  runApp(MyApp());
  removeSplash();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<OnboardingBloc>()),
        BlocProvider(create: (_) => serviceLocator<ImagePickerBloc>()),
        BlocProvider(
          create: (_) {
            final authBloc = serviceLocator<AuthBloc>();
            authBloc.add(AuthCheckStatusEvent());
            return authBloc;
          },
        ),
        BlocProvider(create: (_) => serviceLocator<DrawerBloc>()),
        BlocProvider(
          create: (_) {
            final profileBloc = serviceLocator<ProfileBloc>();
            profileBloc.add(GetProfileEvent());
            return profileBloc;
          },
        ),
        BlocProvider(create: (_) => serviceLocator<MoodBloc>()),
        BlocProvider(create: (_) => serviceLocator<FoodBloc>()),
      ],
      child: MaterialApp.router(
        title: 'MoodEats: Consumer',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
