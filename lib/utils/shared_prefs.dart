import 'dart:convert';

import 'package:efficient_school/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsConstants {
  static const currentUser = "current_user";
}

class SharedPrefs {
  static late SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  Future<void> clearSharedPrefs() async {
    await _sharedPrefs.clear();
  }

  User? get getCurrentUser {
    final String currentUserString =
        _sharedPrefs.getString(PrefsConstants.currentUser) ?? '';
    if (currentUserString.isNotEmpty) {
      Map<String, dynamic> userMap = jsonDecode(currentUserString);
      return User(
        userName: userMap['userName'],
        profileImage: userMap['profileImage'],
      );
    }
    return null;
  }

  set setCurrentUser(User user) {
    final String userString = jsonEncode(user.toMap());
    _sharedPrefs.setString(PrefsConstants.currentUser, userString);
  }
}
