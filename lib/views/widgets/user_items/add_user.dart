import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/utils/inputvalidatsiya.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final User user = User(
      id: 0,
      apiId: "",
      name: "",
      surname: "",
      phoneNumber: "",
      workPlace: "",
      login: "",
      password: "",
      role: "");
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Add User",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            CupertinoIcons.person_fill,
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Ism',
                        ),
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
                      SizedBox(height: 16.h),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            CupertinoIcons.person_fill,
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Familiya',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Hodim familyasini kriting";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          user.surname = value!;
                        },
                      ),
                       SizedBox(height: 16.h),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            CupertinoIcons.person_fill,
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Hodim mansabini kiriting',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Hodim mansabini kriting";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          user.surname = value!;
                        },
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Passport seriya',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !Validate.passportSerialNumber(value)) {
                            return "Passport seriya kriting";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) { 
                          user.login = value!;
                        },
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Telefon raqam',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !Validate.phone(value)) {
                            return "Telefon raqam kriting";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          user.phoneNumber = value!;
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Saqlash"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
