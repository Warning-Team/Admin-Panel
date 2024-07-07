import 'package:admin_panel/controllers/auth_controller.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/services/http_services/users_http_service.dart';
import 'package:admin_panel/utils/inputvalidatsiya.dart';
import 'package:admin_panel/utils/make_user_to_add.dart';
import 'package:admin_panel/utils/user_input_validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final usersHttpService = UsersHttpService();
  final idChecker = UserInputValidation();
  final User user = User(id: 0, apiId: "userApiId", name: "", surname: "", phoneNumber: "", workPlace: "", login: "", password: "", role: "");

  saveUser() async {
    final makeUser = MakeUserToAdd();
    _formKey.currentState!.save();
    User makedUser = await makeUser.makeUser(user);

    Navigator.pop(context);
    authController.register(
      "${makedUser.name}${makedUser.surname}@gmail.com",
      makedUser.password,
    );

    usersHttpService.postUser(makedUser);
    setState(() {});
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Yangi foydalanuvchi uchun login: ${makedUser.login}",
                ),
                Text(
                  "Yangi foydalanuvchi uchun parol: ${makedUser.password}",
                ),
                Text(
                  "Yangi foydalanuvchi Id' si: ${makedUser.id}",
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.check,
                )),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blueAccent,
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Add User",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                            if (value == null || value.trim().isEmpty || !Validate.isLengthGreaterThanFour(value)) {
                              return "Hodim ismini to'g'ri kriting";
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
                            if (value == null || value.trim().isEmpty || !Validate.isLengthGreaterThanFour(value)) {
                              return "Hodim familyasini to'g'ri kriting";
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
                            labelText: 'Hodim mansabini kiriting',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty || !Validate.isLengthGreaterThanFour(value)) {
                              return "Hodim mansabini to'g'ri kriting";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            user.role = value!;
                          },
                        ),
                        SizedBox(height: 16.h),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Tumanni kiriting',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty || !Validate.isLengthGreaterThanFour(value)) {
                              return "Ish joyini to'g'ri kriting";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            user.workPlace = value!;
                          },
                        ),
                        SizedBox(height: 16.h),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Passport seriya',
                          ),
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
                        SizedBox(height: 16.h),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Telefon raqam',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty || !Validate.phone(value)) {
                              return "Telefon raqam kriting";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            user.phoneNumber = value!;
                          },
                        ),
                        const SizedBox(height: 36),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              saveUser();
                              setState(() {});
                            }
                          },
                          child: const Text(
                            "Saqlash",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}
