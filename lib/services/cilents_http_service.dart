import 'dart:convert';

import 'package:admin_panel/models/client.dart';
import 'package:http/http.dart' as http;

class CilentsHttpService {
  Future<List<Client>> getData() async {
    List<Client> clients = [];
    final uri = Uri.parse("https://savdosanoatapp-default-rtdb.firebaseio.com/clients.json");

    final response = await http.get(uri);
    Map datas = jsonDecode(response.body);
    datas.forEach((key, value) {
      Client client = Client.fromJson(key, value);
      clients.add(client);
    });
    return clients;
  }

  Future<void> deleteClient(String id) async {
    final uri = Uri.parse("https://savdosanoatapp-default-rtdb.firebaseio.com/clients/${id}.json");
    final response = await http.delete(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> editClient(Client client) async {
    final uri = Uri.parse("https://savdosanoatapp-default-rtdb.firebaseio.com/clients/${client.apiId}.json");
    await http.put(uri,
        body: json.encode(
          client.toJson(),
        ));
  }

  Future<void> addClient(Client client) async {
    final uri = Uri.parse("https://savdosanoatapp-default-rtdb.firebaseio.com/clients.json");
    final response = await http.post(uri,
        body: json.encode(
          client.toJson(),
        ));
    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }
}
