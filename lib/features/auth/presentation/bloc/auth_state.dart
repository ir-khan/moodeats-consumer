part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthSuccessState extends AuthState {
  // final UserEntity user;
  // AuthSuccessState(this.user);

  @override
  List<Object?> get props => [];
}

final class AuthFailureState extends AuthState {
  final String error;
  AuthFailureState(this.error);

  @override
  List<Object?> get props => [error];
}

final class AuthUnAuthenticatedState extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthAuthenticatedState extends AuthState {

  @override
  List<Object?> get props => [];
}

final class AuthResendOtpDisabledState extends AuthState {
  final int remainingTime;
  AuthResendOtpDisabledState(this.remainingTime);

  @override
  List<Object?> get props => [remainingTime];
}

final class AuthResendOtpEnabledState extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AvatarUploadLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

final class PasswordLoginVisibilityState extends AuthState {
  final bool isPasswordLoginVisible;

  PasswordLoginVisibilityState({required this.isPasswordLoginVisible});

  @override
  List<Object?> get props => [isPasswordLoginVisible];
}

final class PasswordRegisterVisibilityState extends AuthState {
  final bool isPasswordRegisterVisible;

  PasswordRegisterVisibilityState({required this.isPasswordRegisterVisible});

  @override
  List<Object?> get props => [isPasswordRegisterVisible];
}

// final class ConfirmPasswordRegisterVisibilityState extends AuthState {
//   final bool isConfirmPasswordRegisterVisible;

//   ConfirmPasswordRegisterVisibilityState({required this.isConfirmPasswordRegisterVisible});
// }
