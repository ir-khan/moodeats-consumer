import 'package:consumer/core/domain/entities/user.dart';
import 'package:consumer/core/usecase/usecase.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase
    implements UseCase<DataState<UserEntity>, UpdateProfileParams> {
  final ProfileRepository _profileRepository;

  UpdateProfileUseCase(this._profileRepository);
  @override
  Future<DataState<UserEntity>> call(UpdateProfileParams params) async {
    return await _profileRepository.updateProfile(
      name: params.name,
      phone: params.phone,
    );
  }
}

class UpdateProfileParams {
  final String name;
  final String phone;

  UpdateProfileParams({required this.name, required this.phone});
}
