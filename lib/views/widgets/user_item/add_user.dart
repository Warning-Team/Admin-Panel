import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/utils/inputvalidatsiya.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  User user = User(id: 0, apiId: "", name: "", surname: "", phoneNumber: "", workPlace: "", login: "", password: "", role: "");
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add User"),
      content: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "name", labelText: 'name'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Hodim ismini kriting";
              } else {
                return null;
              }
            },
            onSaved: (value) {
              user.name = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "passport seriya", labelText: 'passport seriya'),
            validator: (value) {
              if (value == null || value.trim().isEmpty || !Validate.passportSerialNumber(value)) {
                return "Passport seriya kriting";
              } else {
                return null;
              }
            },
            onSaved: (value) {
              user.login = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "phone", labelText: 'phone'),
            validator: (value) {
              if (value == null || value.trim().isEmpty || !Validate.passportSerialNumber(value)) {
                return "phone kriting";
              } else {
                return null;
              }
            },
            onSaved: (value) {
              user.login = value!;
            },
          ),
        ],
      ),
    );
  }
}
