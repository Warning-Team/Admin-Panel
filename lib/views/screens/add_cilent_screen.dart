import 'package:flutter/material.dart';

class AddCilentScreen extends StatefulWidget {
  const AddCilentScreen({super.key});

  @override
  State<AddCilentScreen> createState() => _AddCilentScreenState();
}

class _AddCilentScreenState extends State<AddCilentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text("Add Client"),
      ),
    );
  }
}
