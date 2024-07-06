import 'package:admin_panel/controllers/users_controller.dart';
import 'package:admin_panel/views/widgets/user_items/add_user.dart';
import 'package:admin_panel/views/widgets/user_items/show_user.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
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
            padding: EdgeInsets.all(10.w),
            itemCount: users.length,
            itemBuilder: (ctx, index) {
              return Column(
                children: [
                  ShowUser(user: users[index]),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: AddUser(),
    );
  }
}
