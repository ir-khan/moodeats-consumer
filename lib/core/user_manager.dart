import 'package:consumer/core/constants/storage_keys.dart';
import 'package:hive/hive.dart';
import 'package:consumer/core/data/models/user_model.dart';

class UserManager {
  final Box _box;

  UserManager(this._box);

  /// Save user data to Hive
  Future<void> saveUser(UserModel user) async {
    await _box.put(StorageKeys.userData, user.toJson());
  }

  /// Retrieve user data from Hive
  UserModel? getUser() {
    var userJson = _box.get(StorageKeys.userData);
    if (userJson == null) return null;
    return UserModel.fromJson(Map<String, dynamic>.from(userJson));
  }

    /// Update User Profile (Local)
  Future<void> updateUser({
    String? name,
    String? phone,
    String? avatar,
  }) async {
    var user = getUser();
    if (user == null) return;

    final updatedUser = user.copyWith(
      name: name ?? user.name,
      phone: phone ?? user.phone,
      avatar: avatar ?? user.avatar,
    );

    await saveUser(updatedUser);
  }

  /// Clear user data on logout
  Future<void> clearUser() async {
    await _box.delete(StorageKeys.userData);
  }
}
