import 'dart:math';
import 'package:admin_panel/models/client.dart';
import 'package:admin_panel/utils/user_input_validation.dart';

class MakeClientToAdd {
  final checker = UserInputValidation();
 

  Future makeClient(Client client) async {
    client.id= await makeIdClient();
    return client;
  }

  Future<int> makeIdClient() async {
    while (true) {
      int id = Random().nextInt(90000) + 10000;
      int response = await checker.checkIdClient(id.toString());
      if (response == 0) {
        return id;
      }
    }
  }

}
