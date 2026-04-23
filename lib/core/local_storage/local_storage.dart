import 'package:assignment_dog/data/models/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveConst {
  static const String storageName = 'userData';
  static const String userList = 'userList';
  static const String sessionUser = 'sessionUser';

  static const String isLoggedIn = 'isLoggedIn'; // ✅ NEW
}

abstract class LocalStorage {
  Future<UserModel> authenticate(UserModel user); // signup OR login
  Future<UserModel?> getCurrentUser(); // session user
  bool isLoggedIn();
  Future<void> logout();
  Future<void> clearAllBox();
  Future<void> clearSession();
}

class HiveStorageImp extends LocalStorage {
  final Box userBox;

  HiveStorageImp({required this.userBox});

  static Future<LocalStorage> init() async =>
      HiveStorageImp(userBox: await Hive.openBox(HiveConst.storageName));

  @override
  Future<UserModel> authenticate(UserModel user) async {
    List users = userBox.get(HiveConst.userList, defaultValue: []);

    final index = users.indexWhere(
      (u) =>
          u['userName'].toString().toLowerCase() ==
              user.username?.toLowerCase() &&
          u['password'].toString().trim() == user.password?.trim(),
    );

    if (index != -1) {
      /// LOGIN
      final existingUser = users[index];

      /// Save session
      await userBox.put(HiveConst.sessionUser, existingUser);
      await userBox.put(HiveConst.isLoggedIn, true); // ✅

      return UserModel.fromJson(Map<String, dynamic>.from(existingUser));
    } else {
      ///  SIGNUP
      final newUser = user.toJson();

      users.add(newUser);
      await userBox.put(HiveConst.userList, users);

      /// Save session
      await userBox.put(HiveConst.sessionUser, newUser);
      await userBox.put(HiveConst.isLoggedIn, true); // ✅

      return user;
    }
  }

  /// LOGOUT (ONLY SESSION FALSE)
  @override
  Future<void> logout() async {
    await userBox.put(HiveConst.isLoggedIn, false);
  }

  /// GET CURRENT USER (SAFE CAST)
  @override
  Future<UserModel?> getCurrentUser() async {
    final user = userBox.get(HiveConst.sessionUser);

    if (user == null) return null;

    if (user is Map) {
      return UserModel.fromJson(Map<String, dynamic>.from(user));
    }

    return null;
  }

  /// CHECK LOGIN STATE (FIXED)
  @override
  bool isLoggedIn() {
    return userBox.get(HiveConst.isLoggedIn, defaultValue: false);
  }

  ///  FULL RESET (OPTIONAL BUT IMPORTANT)
  @override
  Future<void> clearSession() async {
    await userBox.delete(HiveConst.sessionUser);
    await userBox.put(HiveConst.isLoggedIn, false);
  }

  @override
  Future<void> clearAllBox() async {
    await userBox.clear();
  }
}
