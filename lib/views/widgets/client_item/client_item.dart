import 'package:admin_panel/models/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ClientItem extends StatelessWidget {
  Client client;
  ClientItem({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
          child: ListTile(
            title: Text(client.companyName),
            subtitle: Text(
              "phone:  ${client.phoneNumber}",
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}
