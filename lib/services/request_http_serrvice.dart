import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:admin_panel/models/request.dart';

class RequestsHttpService {
  final String baseUrl =
      "https://savdosanoatapp-default-rtdb.firebaseio.com/requests";

  Future<Request> getRequest(String requestId) async {
    final uri = Uri.parse("$baseUrl/$requestId.json");

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

  Future<void> addRequest(Request request) async {
    final uri = Uri.parse("$baseUrl.json");
    try {
      final response = await http.post(
        uri,
        body: jsonEncode({
          'id': request.id,
          'eId': request.eId,
          'cId': request.cId,
          'date': request.date.toIso8601String(),
          'description': request.description,
          'imgUrls': request.imgUrls,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add request');
      }
    } catch (e) {
      throw Exception('Error adding request: $e');
    }
  }

  Future<void> updateRequest(String requestId, Request request) async {
    final uri = Uri.parse("$baseUrl/$requestId.json");
    try {
      final response = await http.put(
        uri,
        body: jsonEncode({
          'id': request.id,
          'eId': request.eId,
          'cId': request.cId,
          'date': request.date.toIso8601String(),
          'description': request.description,
          'imgUrls': request.imgUrls,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update request');
      }
    } catch (e) {
      throw Exception('Error updating request: $e');
    }
  }

  Future<void> deleteRequest(String requestId) async {
    final uri = Uri.parse("$baseUrl/$requestId.json");
    try {
      final response = await http.delete(uri);

      if (response.statusCode != 200) {
        throw Exception('Failed to delete request');
      }
    } catch (e) {
      throw Exception('Error deleting request: $e');
    }
  }
}
