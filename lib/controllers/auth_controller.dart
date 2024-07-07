import 'package:admin_panel/services/firebase_services/user_auth_service.dart';
import 'package:flutter/material.dart';


class AuthController with ChangeNotifier {
  Future<void> login(String email, String password) async {
    await FirebaseAuthService.login(email: email, password: password);
  }

  Future<void> register(String email, String password) async {
    await FirebaseAuthService.register(email: email, password: password);
    notifyListeners();
  }
}