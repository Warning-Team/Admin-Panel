import 'package:admin_panel/models/client.dart';
import 'package:admin_panel/services/http_services/cilents_http_service.dart';

class CilentsController {
  CilentsHttpService clientsHttpService = CilentsHttpService();
  





  Future<void> addClient(Client client) async {
    clientsHttpService.addClient(client);
    
  }
}
