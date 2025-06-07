import 'package:consumer/config/routes/app_router.dart';
import 'package:consumer/core/constants/storage_keys.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final FlutterSecureStorage _storage;
  OnboardingBloc({required FlutterSecureStorage storage})
    : _storage = storage,
      super(OnboardingChangeState(currentPage: 0)) {
    on<OnboardingPageChangedEvent>(_changeOnboardingPage);
    on<OnboardingSkipedOrNavigatedEvent>(_skipOrNavigate);
  }

  void _changeOnboardingPage(
    OnboardingPageChangedEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingChangeState(currentPage: event.page));
  }

  void _skipOrNavigate(
    OnboardingSkipedOrNavigatedEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    await _storage.write(key: StorageKeys.hasSeenOnboarding, value: 'true');
    await AppRouter.preloadFlags();
    emit(OnboardingSkipedOrNavigatedState());
  }
}
