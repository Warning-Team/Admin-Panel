import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/services/http_services/users_http_service.dart';

class UsersController {
  final usersHttpService = UsersHttpService();
  List<User> _users = [
   
  ];
  List<User> get users{
    return [..._users];
  }

  Future<List<User>>  getUsers() async {
    _users = await usersHttpService.getUsers();
    return [..._users];
  }

  
}
