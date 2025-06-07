import 'package:consumer/core/usecase/usecase.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/auth/domain/repositories/auth_repository.dart';

class UserIsAuthenticatedUseCase implements UseCase<DataState<bool>, void> {
  final AuthRepository _authRepository;

  const UserIsAuthenticatedUseCase(this._authRepository);

  @override
  Future<DataState<bool>> call(void params) async {
    return await _authRepository.isAuthenticated();
  }
}
