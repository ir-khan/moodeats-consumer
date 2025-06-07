import 'dart:io';

import 'package:consumer/core/domain/entities/user.dart';
import 'package:consumer/core/utils/data_state.dart';
import 'package:consumer/features/profile/domain/usecases/get_profile.dart';
import 'package:consumer/features/profile/domain/usecases/update_avatar.dart';
import 'package:consumer/features/profile/domain/usecases/update_profile.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;
  final UpdateAvatarUseCase _updateAvatarUseCase;
  ProfileBloc({
    required GetProfileUseCase getProfileUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required UpdateAvatarUseCase updateAvatarUseCase,
  }) : _getProfileUseCase = getProfileUseCase,
       _updateProfileUseCase = updateProfileUseCase,
       _updateAvatarUseCase = updateAvatarUseCase,
       super(ProfileInitial()) {
    on<GetProfileEvent>(_getProfileRequested);
    on<UpdateProfileEvent>(_updateProfileRequested);
    on<UpdateAvatarEvent>(_updateAvatarRequested);
  }

  Future<void> _getProfileRequested(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final res = await _getProfileUseCase(null);

    res is DataSuccess<UserEntity>
        ? emit(ProfileLoaded(user: res.extractedData!))
        : emit(ProfileError(message: res.error));
  }

  Future<void> _updateProfileRequested(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final res = await _updateProfileUseCase(
      UpdateProfileParams(name: event.name, phone: event.phone),
    );
    res is DataSuccess<UserEntity>
        ? emit(ProfileLoaded(user: res.extractedData!))
        : emit(ProfileError(message: res.error));
  }

  Future<void> _updateAvatarRequested(
    UpdateAvatarEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final res = await _updateAvatarUseCase(
      UpdateAvatarParams(avatar: event.avatar),
    );
    res is DataSuccess<UserEntity>
        ? emit(ProfileLoaded(user: res.extractedData!))
        : emit(ProfileError(message: res.error));
  }
}
