import 'package:consumer/config/routes/app_router.dart';
import 'package:consumer/core/bloc/image_picker/image_picker_bloc.dart';
import 'package:consumer/core/network/connection_checker.dart';
import 'package:consumer/core/services/services.dart';
import 'package:consumer/core/session_manager.dart';
import 'package:consumer/core/user_manager.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/core/network/api_client.dart';
import 'package:consumer/features/auth/auth.dart';
import 'package:consumer/features/drawer/drawer.dart';
import 'package:consumer/features/food/food.dart';
import 'package:consumer/features/mood_based_recommendation/mood_based_recommendation.dart';
import 'package:consumer/features/onboarding/onboarding.dart';
import 'package:consumer/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initialize() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  var userBox = await Hive.openBox('userBox');

  // Initialize dependencies
  setupLocator(userBox);
  await AppRouter.preloadFlags();
}

Future<void> removeSplash() async {
  // remove splash after 5 sec
  await Future.delayed(const Duration(seconds: 5), () {
    FlutterNativeSplash.remove();
  });
}

void setupLocator(userBox) {
  // Core dependencies
  serviceLocator
    ..registerLazySingleton(() => FlutterSecureStorage())
    ..registerLazySingleton<SessionManager>(
      () => SessionManagerImpl(serviceLocator<FlutterSecureStorage>()),
    )
    ..registerLazySingleton(() => UserManager(userBox))
    ..registerLazySingleton<ApiClient>(
      () => ApiClient(serviceLocator<SessionManager>()),
    )
    ..registerLazySingleton<InternetConnection>(() => InternetConnection())
    ..registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator<InternetConnection>()),
    )
    ..registerLazySingleton<ToastService>(() => ToastService())
    // Utils
    ..registerLazySingleton<ImagePickerUtil>(() => ImagePickerUtil())
    // Blocs
    ..registerLazySingleton<ImagePickerBloc>(
      () => ImagePickerBloc(serviceLocator()),
    )
    ..registerLazySingleton<OnboardingBloc>(
      () => OnboardingBloc(storage: serviceLocator()),
    )
    ..registerLazySingleton<DrawerBloc>(() => DrawerBloc());

  _initAuth();
  _initProfile();
  _initMoodBasedRecommendation();
  _initFood();
}

void _initAuth() {
  serviceLocator
    // Datasource
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator<ApiClient>()),
    )
    // Repository
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator<AuthRemoteDataSource>(),
        serviceLocator<SessionManager>(),
        serviceLocator<UserManager>(),
        serviceLocator<ConnectionChecker>(),
      ),
    )
    // Usecases
    ..registerLazySingleton<UserSignupUseCase>(
      () => UserSignupUseCase(serviceLocator<AuthRepository>()),
    )
    ..registerLazySingleton<UserLoginUseCase>(
      () => UserLoginUseCase(serviceLocator<AuthRepository>()),
    )
    ..registerLazySingleton<UserLogoutUseCase>(
      () => UserLogoutUseCase(serviceLocator<AuthRepository>()),
    )
    ..registerLazySingleton<UserIsAuthenticatedUseCase>(
      () => UserIsAuthenticatedUseCase(serviceLocator<AuthRepository>()),
    )
    ..registerLazySingleton<OTPRequestUseCase>(
      () => OTPRequestUseCase(serviceLocator<AuthRepository>()),
    )
    ..registerLazySingleton<OTPVerifyUseCase>(
      () => OTPVerifyUseCase(serviceLocator<AuthRepository>()),
    )
    // Bloc
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        userSignupUseCase: serviceLocator<UserSignupUseCase>(),
        userLoginUseCase: serviceLocator<UserLoginUseCase>(),
        userLogoutUseCase: serviceLocator<UserLogoutUseCase>(),
        userIsAuthenticatedUseCase:
            serviceLocator<UserIsAuthenticatedUseCase>(),
        otpRequestUseCase: serviceLocator<OTPRequestUseCase>(),
        otpVerifyUseCase: serviceLocator<OTPVerifyUseCase>(),
      ),
    );
}

void _initProfile() {
  serviceLocator
    // Datasource
    ..registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(serviceLocator<ApiClient>()),
    )
    // Repository
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        serviceLocator<ProfileRemoteDataSource>(),
        serviceLocator<UserManager>(),
        serviceLocator<ConnectionChecker>(),
      ),
    )
    // Usecases
    ..registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(serviceLocator<ProfileRepository>()),
    )
    ..registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(serviceLocator<ProfileRepository>()),
    )
    ..registerLazySingleton<UpdateAvatarUseCase>(
      () => UpdateAvatarUseCase(serviceLocator<ProfileRepository>()),
    )
    // Bloc
    ..registerLazySingleton<ProfileBloc>(
      () => ProfileBloc(
        getProfileUseCase: serviceLocator<GetProfileUseCase>(),
        updateProfileUseCase: serviceLocator<UpdateProfileUseCase>(),
        updateAvatarUseCase: serviceLocator<UpdateAvatarUseCase>(),
      ),
    );
}

void _initMoodBasedRecommendation() {
  serviceLocator
    // Datasource
    ..registerLazySingleton<MoodRemoteDataSource>(
      () => MoodRemoteDataSourceImpl(serviceLocator<ApiClient>()),
    )
    // Repository
    ..registerLazySingleton<MoodRepository>(
      () => MoodRepositoryImpl(
        serviceLocator<MoodRemoteDataSource>(),
        serviceLocator<ConnectionChecker>(),
      ),
    )
    // Usecases
    ..registerLazySingleton<GetRecommendationUseCase>(
      () => GetRecommendationUseCase(serviceLocator<MoodRepository>()),
    )
    // Bloc
    ..registerLazySingleton<MoodBloc>(
      () => MoodBloc(
        getRecommendation: serviceLocator<GetRecommendationUseCase>(),
      ),
    );
}

void _initFood() {
  serviceLocator
    // Datasource
    ..registerLazySingleton<FoodRemoteDataSource>(
      () => FoodRemoteDataSourceImpl(serviceLocator<ApiClient>()),
    )
    // Repository
    ..registerLazySingleton<FoodRepository>(
      () => FoodRepositoryImpl(
        serviceLocator<FoodRemoteDataSource>(),
        serviceLocator<ConnectionChecker>(),
      ),
    )
    // Usecases
    ..registerLazySingleton<GetAllFoodsUseCase>(
      () => GetAllFoodsUseCase(serviceLocator<FoodRepository>()),
    )
    // Bloc
    ..registerLazySingleton<FoodBloc>(
      () => FoodBloc(getAllFoodsUseCase: serviceLocator<GetAllFoodsUseCase>()),
    );
}
