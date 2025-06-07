import 'dart:io';

import 'package:consumer/core/network/api_client.dart';
import 'package:consumer/core/network/api_endpoints.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:dio/dio.dart';

abstract interface class AuthRemoteDataSource {
  Future<Response> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String role,
    File? avatar,
  });
  Future<Response> login({required String email, required String password});
  Future<Response> logout();
  Future<Response> refreshAccessToken({required String refreshToken});
  Future<Response> requestOTP({required String phone});
  Future<Response> verifyOTP({required String phone, required String otp});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Response> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String role,
    File? avatar,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "role": role,
        if (avatar != null)
          "avatar": await MultipartFile.fromFile(
            avatar.path,
            filename: avatar.path.split("/").last,
          ),
      });

      Response response = await _apiClient.dio.post(
        ApiEndpoints.authRegister,
        data: formData,
      );
      return response;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? "Server error during registration.",
      );
    } on SocketException {
      throw NetworkException("No Internet connection.");
    } catch (e) {
      throw InternalException("Unexpected error occurred during registration.");
    }
  }

  @override
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _apiClient.dio.post(
        ApiEndpoints.authLogin,
        data: {"email": email, "password": password},
      );
      return response;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? "Server error during login.",
      );
    } on SocketException {
      throw NetworkException("No Internet connection.");
    } catch (e) {
      throw InternalException("Unexpected error occurred during login.");
    }
  }

  @override
  Future<Response> logout() async {
    try {
      Response response = await _apiClient.dio.post(ApiEndpoints.authLogout);
      return response;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? "Server error during logout.",
      );
    } on SocketException {
      throw NetworkException("No Internet connection.");
    } catch (e) {
      throw InternalException("Unexpected error occurred during logout.");
    }
  }

  @override
  Future<Response> refreshAccessToken({required String refreshToken}) async {
    try {
      Response response = await _apiClient.dio.post(
        ApiEndpoints.authRefreshToken,
        data: {"refreshToken": refreshToken},
      );
      return response;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? "Server error during refreshing token.",
      );
    } on SocketException {
      throw NetworkException("No Internet connection.");
    } catch (e) {
      throw InternalException("Unexpected error occurred during registration.");
    }
  }

  @override
  Future<Response> requestOTP({required String phone}) async {
    try {
      Response response = await _apiClient.dio.post(
        ApiEndpoints.otpRequest,
        data: {"phone": phone},
      );
      return response;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? "Server error while requesting OTP.",
      );
    } on SocketException {
      throw NetworkException("No Internet connection.");
    } catch (e) {
      throw InternalException(
        "Unexpected error occurred while requesting OTP.",
      );
    }
  }

  @override
  Future<Response> verifyOTP({
    required String phone,
    required String otp,
  }) async {
    try {
      Response response = await _apiClient.dio.post(
        ApiEndpoints.otpVerify,
        data: {"phone": phone, "otp": otp},
      );
      return response;
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? "Server error while verifying OTP.",
      );
    } on SocketException {
      throw NetworkException("No Internet connection.");
    } catch (e) {
      throw InternalException("Unexpected error occurred while verifying OTP.");
    }
  }
}
