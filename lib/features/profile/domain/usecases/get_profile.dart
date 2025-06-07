import 'package:consumer/core/domain/entities/user.dart';
import 'package:consumer/core/usecase/usecase.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase implements UseCase<DataState<UserEntity>, void> {
  final ProfileRepository _profileRepository;

  GetProfileUseCase(this._profileRepository);
  @override
  Future<DataState<UserEntity>> call(void params) async {
    return await _profileRepository.getProfile();
  }
}
