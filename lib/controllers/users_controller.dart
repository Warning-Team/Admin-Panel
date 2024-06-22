import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/services/users_http_service.dart';

class UsersController {
  final usersHttpService = UsersHttpService();
  List<User> _users = [
    User(
      id: 12345,
      apiId: "user1",
      name: "Samandar",
      surname: "Allaberdiyev",
      phoneNumber: "+998911234567",
      workPlace: "Tashkent",
      login: "AD1234566",   
      password: "Samandar",
      role: "Employee",
    ),
  ];
  List<User> get users{
    return [..._users];
  }

  Future<List<User>>  getUsers() async {
    _users = await usersHttpService.getUsers();
    return [..._users];
  }

  
}
