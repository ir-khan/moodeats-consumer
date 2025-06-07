import 'package:consumer/core/usecase/usecase.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/auth/domain/repositories/auth_repository.dart';

class UserLogoutUseCase implements UseCase<DataState<void>, void> {
  final AuthRepository _authRepository;

  const UserLogoutUseCase(this._authRepository);

  @override
  Future<DataState<void>> call(void params) async {
    return await _authRepository.logout();
  }
}
