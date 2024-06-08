import 'package:admin_panel/controllers/cilents_controller.dart';
import 'package:flutter/material.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  CilentsController cilentsController = CilentsController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Clients",
        ),
        backgroundColor: Colors.blue.shade700,
      ),
      body: FutureBuilder(
        future: cilentsController.cilentsHttpService.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Malumot olishda xato  bor"),
            );
          }



          
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Malumot yo'q"),
            );
          }
          return Center();
        },
      ),
    );
  }
}
