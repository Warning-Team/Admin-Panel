import 'package:flutter/material.dart';

class ProfileEdit extends StatelessWidget {
  final String title;

  TextEditingController controller;

  ProfileEdit(
      {required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(
          title,
        ),
        border: OutlineInputBorder(),
      ),
    );
  }

 static String returnValue(String value){
    return value;
  }
}
