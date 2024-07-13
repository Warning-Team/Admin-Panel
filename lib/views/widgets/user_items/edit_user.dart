import 'package:flutter/material.dart';

class ProfileEdit extends StatelessWidget {

  final String title;
  final String value;

  ProfileEdit({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final placeController = TextEditingController();
    final loginController = TextEditingController();
    final passwordController = TextEditingController();
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
          label: Text(
            title,
          ),
          border: OutlineInputBorder(),),
    );
  }
}
