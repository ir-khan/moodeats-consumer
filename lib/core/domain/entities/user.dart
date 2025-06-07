import 'package:consumer/core/enums/enums.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final UserRole role;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.role,
  });

  @override
  List<Object> get props => [uid, name, email, phone, avatar, role];
}
