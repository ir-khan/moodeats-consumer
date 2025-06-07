part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

final class GetProfileEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

final class UpdateProfileEvent extends ProfileEvent {
  final String name;
  final String phone;

  const UpdateProfileEvent({required this.name, required this.phone});
  @override
  List<Object?> get props => [name, phone];
}

final class UpdateAvatarEvent extends ProfileEvent {
  final File avatar;

  const UpdateAvatarEvent({required this.avatar});
  @override
  List<Object?> get props => [avatar];
}
