import 'dart:async';
import 'dart:io';

import 'package:consumer/core/utils/data_state.dart';
import 'package:consumer/core/domain/entities/user.dart';
import 'package:consumer/features/auth/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignupUseCase _userSignupUseCase;
  final UserLoginUseCase _userLoginUseCase;
  final UserLogoutUseCase _userLogoutUseCase;
  final UserIsAuthenticatedUseCase _userIsAuthenticatedUseCase;
  final OTPRequestUseCase _otpRequestUseCase;
  final OTPVerifyUseCase _otpVerifyUseCase;

  bool _isPasswordLoginVisible = false;
  bool _isPasswordRegisterVisible = false;
  // bool _isConfirmPasswordRegisterVisible = false;

  AuthBloc({
    required UserSignupUseCase userSignupUseCase,
    required UserLoginUseCase userLoginUseCase,
    required UserLogoutUseCase userLogoutUseCase,
    required UserIsAuthenticatedUseCase userIsAuthenticatedUseCase,
    required OTPRequestUseCase otpRequestUseCase,
    required OTPVerifyUseCase otpVerifyUseCase,
  }) : _userSignupUseCase = userSignupUseCase,
       _userLoginUseCase = userLoginUseCase,
       _userLogoutUseCase = userLogoutUseCase,
       _userIsAuthenticatedUseCase = userIsAuthenticatedUseCase,
       _otpRequestUseCase = otpRequestUseCase,
       _otpVerifyUseCase = otpVerifyUseCase,
       super(AuthInitial()) {
    on<AuthCheckStatusEvent>(_onAuthCheckStatus);
    on<AuthLoginEvent>(_onAuthLoginRequested);
    on<AuthRegisterEvent>(_onAuthRegisterRequested);
    on<AuthLogoutEvent>(_onAuthLogoutRequested);
    on<AuthRequestOtpEvent>(_onAuthRequestOtpRequested);
    on<AuthVerifyOtpEvent>(_onAuthVerifyOtpRequested);
    on<AuthResendOtpEvent>(_onAuthResendOtpRequested);
    on<TogglePasswordLoginVisibilityEvent>(_onTogglePasswordLoginVisibility);
    on<TogglePasswordRegisterVisibilityEvent>(
      _onTogglePasswordRegisterVisibility,
    );
    // on<ToggleConfirmPasswordRegisterVisibilityEvent>(
    //   _onToggleConfirmPasswordRegisterVisibility,
    // );
  }

  Future<void> _onAuthCheckStatus(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    // emit(AuthLoadingState());
    final res = await _userIsAuthenticatedUseCase(null);
    res is DataSuccess<bool>
        ? emit(AuthAuthenticatedState())
        : emit(AuthUnAuthenticatedState());
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final res = await _userLoginUseCase(
      UserLoginParams(email: event.email, password: event.password),
    );
    res is DataSuccess<UserEntity>
        ? emit(AuthAuthenticatedState())
        : emit(AuthFailureState(res.error));
  }

  Future<void> _onAuthRegisterRequested(
    AuthRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final res = await _userSignupUseCase(
      UserSignupParams(
        name: event.name,
        email: event.email,
        password: event.password,
        phone: event.phone,
        avatar: event.avatar,
      ),
    );
    res is DataSuccess<UserEntity>
        ? emit(AuthAuthenticatedState())
        : emit(AuthFailureState(res.error));
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final res = await _userLogoutUseCase(null);
    res is DataSuccess
        ? emit(AuthUnAuthenticatedState())
        : emit(AuthFailureState(res.error));
  }

  Future<void> _onAuthRequestOtpRequested(
    AuthRequestOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _otpRequestUseCase(OTPRequestParams(phone: event.phone));
  }

  Future<void> _onAuthVerifyOtpRequested(
    AuthVerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final res = await _otpVerifyUseCase(
      OTPVerifyParams(phone: event.phone, otp: event.otp),
    );
    res is DataSuccess
        ? emit(AuthSuccessState())
        : emit(AuthFailureState(res.error));
  }

  Future<void> _onAuthResendOtpRequested(
    AuthResendOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final res = await _otpRequestUseCase(OTPRequestParams(phone: event.phone));
    if (res is DataSuccess) {
      // emit(AuthSuccessState());
      int secondsLeft = 60;
      emit(AuthResendOtpDisabledState(secondsLeft));

      Timer.periodic(Duration(seconds: 1), (timer) {
        secondsLeft--;
        if (secondsLeft > 0) {
          Future.microtask(() => add(AuthUpdateResendTimerEvent(secondsLeft)));
        } else {
          timer.cancel();
          Future.microtask(() => add(AuthEnableResendOtpEvent()));
        }
      });
    } else {
      emit(AuthFailureState(res.error));
    }
  }

  void _onTogglePasswordLoginVisibility(
    TogglePasswordLoginVisibilityEvent event,
    Emitter<AuthState> emit,
  ) {
    _isPasswordLoginVisible = !_isPasswordLoginVisible;
    emit(
      PasswordLoginVisibilityState(
        isPasswordLoginVisible: _isPasswordLoginVisible,
      ),
    );
  }

  void _onTogglePasswordRegisterVisibility(
    TogglePasswordRegisterVisibilityEvent event,
    Emitter<AuthState> emit,
  ) {
    _isPasswordRegisterVisible = !_isPasswordRegisterVisible;
    emit(
      PasswordRegisterVisibilityState(
        isPasswordRegisterVisible: _isPasswordRegisterVisible,
      ),
    );
  }

  // void _onToggleConfirmPasswordRegisterVisibility(
  //   ToggleConfirmPasswordRegisterVisibilityEvent event,
  //   Emitter<AuthState> emit,
  // ) {
  //   _isConfirmPasswordRegisterVisible = !_isConfirmPasswordRegisterVisible;
  //   emit(
  //     ConfirmPasswordRegisterVisibilityState(
  //       isConfirmPasswordRegisterVisible: _isConfirmPasswordRegisterVisible,
  //     ),
  //   );
  // }
}
