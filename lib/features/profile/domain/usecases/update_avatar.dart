import 'dart:io';

import 'package:consumer/core/domain/entities/user.dart';
import 'package:consumer/core/usecase/usecase.dart';
import 'package:consumer/core/utils/utils.dart';
import 'package:consumer/features/profile/domain/repositories/profile_repository.dart';

class UpdateAvatarUseCase
    implements UseCase<DataState<UserEntity>, UpdateAvatarParams> {
  final ProfileRepository _profileRepository;

  UpdateAvatarUseCase(this._profileRepository);
  @override
  Future<DataState<UserEntity>> call(UpdateAvatarParams params) async {
    return await _profileRepository.updateAvatar(avatar: params.avatar);
  }
}

class UpdateAvatarParams {
  final File avatar;

  UpdateAvatarParams({required this.avatar});
}
