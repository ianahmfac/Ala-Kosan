import 'package:ala_kosan/models/user_app.dart';
import 'package:ala_kosan/services/auth_service.dart';
import 'package:ala_kosan/services/user_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserApp _user;

  UserApp get user => _user;

  Future<void> getCurrentUser() async {
    _user = await UserService.getUser(AuthService.currentUid);
    notifyListeners();
  }

  void userSignOut() {
    _user = null;
    notifyListeners();
  }

  Future<UserApp> getOwner(String id) {
    return UserService.getUser(id);
  }
}
