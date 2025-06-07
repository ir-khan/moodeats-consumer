import 'dart:io';

import 'package:consumer/core/domain/entities/user.dart';
import 'package:consumer/core/utils/data_state.dart';

abstract interface class ProfileRepository {
  Future<DataState<UserEntity>> getProfile();
  Future<DataState<UserEntity>> updateProfile({
    required String name,
    required String phone,
  });
  Future<DataState<UserEntity>> updateAvatar({required File avatar});
}
