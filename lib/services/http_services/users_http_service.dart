import 'dart:convert';

import 'package:admin_panel/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as ath;
import 'package:http/http.dart' as http;

class UsersHttpService {
  final ath.FirebaseAuth userAuth = ath.FirebaseAuth.instance;

  Future<List<User>> getUsers() async {
    Uri url = Uri.parse(
      "https://savdosanoatapp-default-rtdb.firebaseio.com/users.json",
    );

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<User> loadedUsers = [];
    if (data != null) {
      data.forEach((key, value) {
        value["apiId"] = key;
        loadedUsers.add(User.fromJson(key, value));
      });
    }

    return loadedUsers;
  }

  Future<void> postUser(User user) async {
    Uri url = Uri.parse(
      "https://savdosanoatapp-default-rtdb.firebaseio.com/users.json",
    );

    final response = await http.post(
      url,
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode >= 400) {
      throw Exception('Failed to add user');
    }

    // final data = jsonDecode(response.body);
  }

}
