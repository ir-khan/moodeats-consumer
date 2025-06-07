import 'package:consumer/core/enums/enums.dart';
import 'package:consumer/core/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    required super.phone,
    required super.avatar,
    required super.role,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    UserRole? role,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'role': role.value,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      uid: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      avatar: map['avatar'] as String,
      role: UserRoleExtension.fromString(map['role'] as String),
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, phone: $phone, avatar: $avatar, role: $role)';
  }
}
