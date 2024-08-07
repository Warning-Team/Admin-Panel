import 'dart:convert';
import 'package:admin_panel/services/http_services/cilents_http_service.dart';
import 'package:http/http.dart' as http;

class CilentsController {
  CilentsHttpService cilentsHttpService = CilentsHttpService();

  static Future<Map> getClinetByClientId(int cId) async {
    final url = Uri.parse(
        'https://savdosanoatapp-default-rtdb.firebaseio.com/clients.json?orderBy="id"&equalTo=$cId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map;
      return data.values.first;
    } else {
      return {
        "error": "malumot topilmadi",
      };
    }
  }

  static Future<String> getClinetNameById(int cId) async {
    final url = Uri.parse(
        'https://savdosanoatapp-default-rtdb.firebaseio.com/clients.json?orderBy="id"&equalTo=$cId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map;
      return data.values.first['companyName'];
    } else {
      return "malumot topilmadi";
    }
  }

  static Future<String> getClinetStirById(int cId) async {
    final url = Uri.parse(
        'https://savdosanoatapp-default-rtdb.firebaseio.com/clients.json?orderBy="id"&equalTo=$cId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map;
      return data.values.first['stir'].toString();
    } else {
      return "malumot topilmadi";
    }
  }
}
