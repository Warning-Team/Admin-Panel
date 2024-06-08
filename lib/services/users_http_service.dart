import 'dart:convert';

import 'package:admin_panel/models/user.dart';
import 'package:http/http.dart' as http;

class UsersHttpService {

  
    Future<List<User>> getUsers() async {
  Uri url = Uri.parse("https://savdosanoatapp-default-rtdb.firebaseio.com/users.json",);

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<User> loadedUsers = [];
    if (data != null) {
      data.forEach((key, value) {
        loadedUsers.add(User.fromJson(key,value));
      });
    }

    return loadedUsers;
  }




}
