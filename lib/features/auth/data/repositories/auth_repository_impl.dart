import 'dart:io';

import 'package:consumer/core/enums/enums.dart';
import 'package:consumer/core/network/connection_checker.dart';
import 'package:consumer/core/session_manager.dart';
import 'package:consumer/core/user_manager.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:consumer/core/data/models/user_model.dart';
import 'package:consumer/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final SessionManager _sessionManager;
  final UserManager _userManager;
  final ConnectionChecker _connectionChecker;

  AuthRepositoryImpl(
    this._authRemoteDataSource,
    this._sessionManager,
    this._userManager,
    this._connectionChecker,
  );

  @override
  Future<DataState<UserModel>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    File? avatar,
  }) async {
    return _handleRequest<UserModel>(
      () async => await _authRemoteDataSource.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        role: UserRole.client.value,
        avatar: avatar,
      ),
      'user',
      (json) => UserModel.fromJson(json),
    );
  }

  @override
  Future<DataState<UserModel>> login({
    required String email,
    required String password,
  }) async {
    return _handleRequest<UserModel>(
      () async =>
          await _authRemoteDataSource.login(email: email, password: password),
      'user',
      (json) => UserModel.fromJson(json),
      saveTokens: true,
      saveUser: true,
    );
  }

  @override
  Future<DataState<void>> logout() async {
    if (!await _connectionChecker.isConnected) {
      return DataFailure(error: 'No internet connection');
    }

    try {
      final response = await _authRemoteDataSource.logout();
      if (response.statusCode == 200) {
        final responseData = DataSuccess(
          statusCode: response.statusCode!,
          message: 'Logout Successfully!',
          data: {},
          success: true,
        );
        return responseData;
      }
      return DataFailure(error: response.statusMessage ?? 'Request failed');
    } on AppException catch (e) {
      return DataFailure(error: e.message);
    } catch (e) {
      return DataFailure(error: 'Unexpected error occurred');
    }
  }

  @override
  Future<DataState<UserModel?>> refreshAccessToken() async {
    final refreshToken = await _sessionManager.getRefreshToken();
    if (refreshToken == null) {
      return DataFailure(error: 'Refresh token not found');
    }

    return _handleRequest<UserModel?>(
      () async => await _authRemoteDataSource.refreshAccessToken(
        refreshToken: refreshToken,
      ),
      'user',
      (json) => UserModel.fromJson(json),
      saveTokens: true,
    );
  }

  @override
  Future<DataState<bool>> isAuthenticated() async {
    final accessToken = await _sessionManager.getAccessToken();

    if (accessToken != null) {
      return DataSuccess<bool>(
        statusCode: 200,
        message: 'User is authenticated',
        data: {},
        success: true,
        extractedData: true,
      );
    }

    return DataFailure<bool>(
      statusCode: 401,
      error: 'User is not authenticated',
    );
  }

  // @override
  // Future<DataState<UserModel>> getCurrentUser() async {
  //   final storedUser = await _authLocalDataSource.getUser();
  //   if (storedUser != null) {
  //     return DataSuccess<UserModel>(
  //       statusCode: 200,
  //       message: 'User retrieved from local storage',
  //       data: {},
  //       success: true,
  //       extractedData: storedUser,
  //     );
  //   }

  //   return _handleRequest<UserModel>(
  //     () async => await _authRemoteDataSource.getCurrentUser(),
  //     'user',
  //     (json) => UserModel.fromJson(json),
  //     saveUser: true,
  //   );
  // }

  @override
  Future<DataState<void>> requestOTP({required String phone}) async {
    return _handleRequest<void>(
      () async => await _authRemoteDataSource.requestOTP(phone: phone),
      null,
      (_) {},
    );
  }

  @override
  Future<DataState<void>> verifyOTP({
    required String phone,
    required String otp,
  }) {
    return _handleRequest<void>(
      () async => await _authRemoteDataSource.verifyOTP(phone: phone, otp: otp),
      null,
      (_) {},
    );
  }

  /// Handles API requests safely
  Future<DataState<T>> _handleRequest<T>(
    Future Function() apiCall,
    String? key,
    T Function(Map<String, dynamic>) fromJsonT, {
    bool saveTokens = false,
    bool saveUser = false,
  }) async {
    if (!await _connectionChecker.isConnected) {
      return DataFailure(error: 'No internet connection');
    }

    try {
      final response = await apiCall();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = DataSuccess<T>.fromJson(
          response.data,
          key,
          fromJsonT,
        );

        if (saveTokens) {
          await _sessionManager.saveTokens(
            accessToken: responseData.data['accessToken'],
            refreshToken: responseData.data['refreshToken'],
          );
        }

        if (saveUser && responseData.extractedData != null) {
          await _userManager.saveUser(responseData.extractedData! as UserModel);
        }

        return responseData;
      }
      return DataFailure(error: response.statusMessage ?? 'Request failed');
    } on AppException catch (e) {
      return DataFailure(error: e.message);
    } catch (e) {
      return DataFailure(error: 'Unexpected error occurred');
    }
  }
}
