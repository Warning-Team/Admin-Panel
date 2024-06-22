import 'dart:convert';
import 'package:admin_panel/models/request.dart';
import 'package:http/http.dart' as http;

class RequestsHttpService {
  Future<Request> getRequest(String requestId) async {
    final uri = Uri.parse(
        "https://savdosanoatapp-default-rtdb.firebaseio.com/requests/$requestId.json");

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data != null && data is Map<String, dynamic>) {
          return Request.fromJson(data);
        } else {
          throw Exception('Invalid JSON format');
        }
      } else {
        throw Exception('Failed to load request: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching request: $e');
    }
  }
}
