import 'dart:io';

import 'package:consumer/core/usecase/usecase.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/core/domain/entities/user.dart';
import 'package:consumer/features/auth/domain/repositories/auth_repository.dart';

class UserSignupUseCase implements UseCase<DataState<UserEntity>, UserSignupParams> {
  final AuthRepository _authRepository;

  const UserSignupUseCase(this._authRepository);

  @override
  Future<DataState<UserEntity>> call(UserSignupParams params) async {
    return await _authRepository.register(
      name: params.name,
      email: params.email,
      password: params.password,
      phone: params.phone,
      avatar: params.avatar
    );
  }
}

class UserSignupParams {
  final String name;
  final String email;
  final String password;
  final String phone;
  File? avatar;

  UserSignupParams({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    this.avatar,
  });
}
