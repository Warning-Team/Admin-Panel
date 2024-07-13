// ignore_for_file: prefer_const_constructors

import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/views/screens/users/users_screen.dart';
import 'package:admin_panel/views/widgets/user_items/profile_detail.dart';
import 'package:admin_panel/views/widgets/user_items/user_profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) {
                  return UsersScreen();
                },
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text('${user.role} Profili'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTAxL3JtNjA5LXNvbGlkaWNvbi13LTAwMi1wLnBuZw.png'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${user.name} ${user.surname}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade300,
                    ),
                  ),
                  Text(
                    user.role,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue.shade300,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  ProfileDetail(title: 'Phone Number', value: user.phoneNumber),
                  SizedBox(height: 16),
                  ProfileDetail(title: 'Work Place', value: user.workPlace),
                  SizedBox(height: 16),
                  ProfileDetail(title: 'Login', value: user.login),
                  SizedBox(height: 16),
                  ProfileDetail(title: 'Password', value: user.password),
                  SizedBox(height: 16),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                fixedSize: Size.fromWidth(
                  250.w,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) {
                      return UserProfileEdit(user: user);
                    },
                  ),
                );
              },
              child: Text(
                "Malumotlarni o'zgartirish",
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
