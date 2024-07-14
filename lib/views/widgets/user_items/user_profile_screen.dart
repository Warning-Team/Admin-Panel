// ignore_for_file: prefer_const_constructors

import 'package:admin_panel/controllers/cilents_controller.dart';
import 'package:admin_panel/controllers/request_controller.dart';
import 'package:admin_panel/models/request.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/utils/extentions/datetime_reformat.dart';
import 'package:admin_panel/views/screens/reques_screen/request_screen.dart';
import 'package:admin_panel/views/screens/users/users_screen.dart';
import 'package:admin_panel/views/widgets/user_items/profile_detail.dart';
import 'package:admin_panel/views/widgets/user_items/user_profile_edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
                builder: (ctx) => UsersScreen(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
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
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTAxL3JtNjA5LXNvbGlkaWNvbi13LTAwMi1wLnBuZw.png',
                    ),
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
                fixedSize: Size.fromWidth(250.w),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => UserProfileEdit(user: user),
                  ),
                );
              },
              child: Text(
                "Malumotlarni o'zgartirish",
                style: TextStyle(fontSize: 19),
              ),
            ),
            Gap(10),
            Row(
              children: [
                SizedBox(width: 10.w),
                Text(
                  "Requests",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: RequestController.getRequests(user.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("Malumot olishda xato"));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty || snapshot.data == null) {
                  return const Center(child: Text("Malumot mavjud emas"));
                }
                final requests = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(5.w),
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request = Request.fromQuery(requests[index]);
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => RequestScreen(request: request),
                            ),
                          );
                        },
                        title: FutureBuilder(
                          initialData: 'Company Name',
                          future: CilentsController.getClinetNameById(request.cId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Text("Company Name");
                            }
                            if (snapshot.hasError || snapshot.data == null) {
                              return Text("Malumot olishda xato");
                            }

                            return Text(snapshot.data!);
                          },
                        ),
                        subtitle: Text(request.date.toFormattedDate()),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
