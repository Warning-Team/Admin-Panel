import 'package:admin_panel/services/firebase_services/user_auth_service.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuthService.login(email: email, password: password);
    } catch (e) {
      rethrow;
      
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await FirebaseAuthService.register(email: email, password: password);
      notifyListeners();
    } catch (e) {
      // Handle the error, e.g., log it or show an error message
      rethrow;
    }
  }
}
