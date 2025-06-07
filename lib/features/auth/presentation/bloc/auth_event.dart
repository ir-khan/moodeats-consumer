part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {}

final class AuthCheckStatusEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

final class AuthRegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String phone;
  final File? avatar;

  AuthRegisterEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    this.avatar,
  });

  @override
  List<Object?> get props => [name, email, password, phone, avatar];
}

final class AuthLogoutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

final class AuthRequestOtpEvent extends AuthEvent {
  final String phone;
  AuthRequestOtpEvent({required this.phone});

  @override
  List<Object?> get props => [phone];
}

final class AuthVerifyOtpEvent extends AuthEvent {
  final String phone;
  final String otp;
  AuthVerifyOtpEvent({required this.phone, required this.otp});

  @override
  List<Object?> get props => [phone, otp];
}

final class AuthResendOtpEvent extends AuthEvent {
  final String phone;
  AuthResendOtpEvent({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class AuthUpdateResendTimerEvent extends AuthEvent {
  final int remainingSeconds;
  AuthUpdateResendTimerEvent(this.remainingSeconds);

  @override
  List<Object?> get props => [remainingSeconds];
}

class AuthEnableResendOtpEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

final class TogglePasswordLoginVisibilityEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

final class TogglePasswordRegisterVisibilityEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

// final class ToggleConfirmPasswordRegisterVisibilityEvent extends AuthEvent {}
