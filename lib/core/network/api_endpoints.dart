class ApiEndpoints {
  static const String serverURL = 'https://apimoodeats.vercel.app/api/v1';
  // static const String serverURL = 'http://192.168.100.244:3333/api/v1';
  // static const String serverURL = 'http://localhost:3333/api/v1';

  static const String authRegister = "/auth/register";
  static const String authLogin = "/auth/login";
  static const String authLogout = "/auth/logout";
  static const String authRefreshToken = "/auth/refresh-token";
  static const String otpRequest = "/otp/request-otp";
  static const String otpVerify = "/otp/verify-otp";
  static const String profile = "/profile";
  static const String avatarUpdate = "/profile/avatar";
  static const String foods = "/foods";
}
