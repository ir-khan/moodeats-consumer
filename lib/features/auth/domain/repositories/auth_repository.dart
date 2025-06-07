import 'dart:io';

import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/core/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<DataState<UserEntity>> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    File? avatar,
  });

  Future<DataState<UserEntity>> login({required String email, required String password});

  Future<DataState<void>> logout();

  Future<DataState<UserEntity?>> refreshAccessToken();

  Future<DataState<bool>> isAuthenticated();

  Future<DataState<void>> requestOTP({required String phone});

  Future<DataState<void>> verifyOTP({required String phone, required String otp});
}
