import 'package:admin_panel/controllers/users_controller.dart';
import 'package:admin_panel/views/widgets/user_items/add_user.dart';

import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final usersController = UsersController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ishchilar",
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: FutureBuilder(
        future: usersController.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Image.asset('assets/gifs/loading.gif'),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Foydalanuvchilar mavjud emas"),
            );
          }

          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Image.asset(
                    "assets/profile_images/man.png",
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  "${users[index].name} ${users[index].surname}",
                ),
                subtitle: Text(
                  users[index].id.toString(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: AddUser(),
    );
  }
}
