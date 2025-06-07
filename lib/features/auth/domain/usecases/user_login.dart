import 'package:consumer/core/usecase/usecase.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/core/domain/entities/user.dart';
import 'package:consumer/features/auth/domain/repositories/auth_repository.dart';

class UserLoginUseCase
    implements UseCase<DataState<UserEntity>, UserLoginParams> {
  final AuthRepository _authRepository;

  const UserLoginUseCase(this._authRepository);

  @override
  Future<DataState<UserEntity>> call(UserLoginParams params) async {
    return await _authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}
