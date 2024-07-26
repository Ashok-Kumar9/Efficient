import 'package:efficient_school/models/user.model.dart';
import 'package:efficient_school/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

class UserNotifier extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  UserNotifier() {
    _loadUser();
  }

  void _loadUser() {
    _user = SharedPrefs().getCurrentUser;
    notifyListeners();
  }

  void updateUser() {
    _user = SharedPrefs().getCurrentUser;
    notifyListeners();
  }
}
