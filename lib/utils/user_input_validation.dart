import 'dart:convert';

import 'package:http/http.dart' as http;

class UserInputValidation {
  Future checkId(String id) async {
    Uri url = Uri.parse(
      "https://savdosanoatapp-default-rtdb.firebaseio.com/users.json?orderBy=%22id%22&equalTo=$id",
    );

    final response = await http.get(url);
    final data = jsonDecode(response.body) as Map;
    if (data.isEmpty) {
      return 0;
    } else {
      return 1;
    }
  }
}
