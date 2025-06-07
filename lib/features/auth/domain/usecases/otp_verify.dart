import 'package:consumer/core/usecase/usecase.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/auth/domain/repositories/auth_repository.dart';

class OTPVerifyUseCase implements UseCase<DataState<void>, OTPVerifyParams> {
  final AuthRepository _authRepository;

  const OTPVerifyUseCase(this._authRepository);

  @override
  Future<DataState<void>> call(OTPVerifyParams params) async {
    return await _authRepository.verifyOTP(
      phone: params.phone,
      otp: params.otp,
    );
  }
}

class OTPVerifyParams {
  final String phone;
  final String otp;

  OTPVerifyParams({required this.phone, required this.otp});
}
