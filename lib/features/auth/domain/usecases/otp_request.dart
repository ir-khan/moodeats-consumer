import 'package:consumer/core/usecase/usecase.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/auth/domain/repositories/auth_repository.dart';

class OTPRequestUseCase implements UseCase<DataState<void>, OTPRequestParams> {
  final AuthRepository _authRepository;

  const OTPRequestUseCase(this._authRepository);

  @override
  Future<DataState<void>> call(OTPRequestParams params) async {
    return await _authRepository.requestOTP(phone: params.phone);
  }
}

class OTPRequestParams {
  final String phone;

  OTPRequestParams({required this.phone,});
}
