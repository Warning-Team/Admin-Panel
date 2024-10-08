// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/views/widgets/user_items/edit_user.dart';
import 'package:admin_panel/views/widgets/user_items/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileEdit extends StatefulWidget {
  final User user;

  const UserProfileEdit({super.key, required this.user});

  @override
  State<UserProfileEdit> createState() => _UserProfileEditState();
}

class _UserProfileEditState extends State<UserProfileEdit> {
  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final phoneController = TextEditingController();
  final placeController = TextEditingController();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('${widget.user.role} Profili'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTAxL3JtNjA5LXNvbGlkaWNvbi13LTAwMi1wLnBuZw.png'),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  ProfileEdit(
                    title: 'Ism va familiya',
                    controller: nameController,
                  ),
                  SizedBox(height: 16),
                  ProfileEdit(
                    title: 'Ishchi mansabi',
                    controller: roleController,
                  ),
                  SizedBox(height: 16.h),
                  ProfileEdit(
                    title: 'Telefon raqam',
                    controller: phoneController,
                  ),
                  SizedBox(height: 16.h),
                  ProfileEdit(
                    title: 'Ish joyi',
                    controller: placeController,
                  ),
                  SizedBox(height: 16.h),
                  ProfileEdit(
                    title: 'Login',
                    controller: loginController,
                  ),
                  SizedBox(height: 16.h),
                  ProfileEdit(
                    title: 'Parol',
                    controller: passwordController,
                    
                  ),
                  SizedBox(height: 16.h),
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
                    builder: (Ctx) {
                      return UserProfileScreen(
                        user: widget.user,
                      );
                    },
                  ),
                );
              },
              child: Text(
                "Malumotlarni saqlash",
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
