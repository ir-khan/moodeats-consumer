import 'dart:io';

import 'package:consumer/core/data/models/user_model.dart';
import 'package:consumer/core/network/connection_checker.dart';
import 'package:consumer/core/user_manager.dart';
import 'package:consumer/core/utils/app_exception.dart';
import 'package:consumer/core/utils/data_state.dart';
import 'package:consumer/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:consumer/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;
  final UserManager _userManager;
  final ConnectionChecker _connectionChecker;

  ProfileRepositoryImpl(
    this._profileRemoteDataSource,
    this._userManager,
    this._connectionChecker,
  );

  @override
  Future<DataState<UserModel>> getProfile() async {
    final localUser = _userManager.getUser();
    if (localUser != null) {
      return DataSuccess<UserModel>(
        statusCode: 200,
        message: '',
        data: {},
        success: true,
        extractedData: localUser,
      );
    }
    return _handleRequest<UserModel>(
      () async => await _profileRemoteDataSource.getProfile(),
      'user',
      (json) => UserModel.fromJson(json),
    );
  }

  @override
  Future<DataState<UserModel>> updateProfile({
    required String name,
    required String phone,
  }) async {
    final response = await _handleRequest<UserModel>(
      () async => await _profileRemoteDataSource.updateProfile(
        name: name,
        phone: phone,
      ),
      'user',
      (json) => UserModel.fromJson(json),
    );

    if (response is DataSuccess<UserModel>) {
      await _userManager.updateUser(name: name, phone: phone);
    }

    return response;
  }

  @override
  Future<DataState<UserModel>> updateAvatar({required File avatar}) async {
    final response = await _handleRequest<UserModel>(
      () async => await _profileRemoteDataSource.updateAvatar(avatar: avatar),
      'user',
      (json) => UserModel.fromJson(json),
    );

    if (response is DataSuccess<UserModel> && response.extractedData != null) {
      await _userManager.updateUser(avatar: response.extractedData?.avatar);
    }

    return response;
  }

  /// Handles API requests safely
  Future<DataState<T>> _handleRequest<T>(
    Future Function() apiCall,
    String? key,
    T Function(Map<String, dynamic>) fromJsonT,
  ) async {
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
        return responseData;
      }
      return DataFailure(error: response.statusMessage ?? 'Request failed');
    } on AppException catch (e) {
      return DataFailure(error: e.message);
    }
  }
}
