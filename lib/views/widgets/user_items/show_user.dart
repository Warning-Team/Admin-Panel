import 'package:admin_panel/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowUser extends StatefulWidget {
  User user;
  ShowUser({super.key, required this.user});

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue.shade200,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            spreadRadius: 1,
            color: Colors.grey.shade500,
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade200,
              child: const Icon(
                CupertinoIcons.profile_circled,
                size: 45,
              ),
            ),
            title: Text("${widget.user.name} ${widget.user.surname}"),
            subtitle: Text(
              "Id:  ${widget.user.id}",
            ),
          ),
        ],
      ),
    );
    ;
  }
}
