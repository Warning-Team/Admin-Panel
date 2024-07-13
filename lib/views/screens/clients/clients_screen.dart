import 'package:admin_panel/controllers/cilents_controller.dart';
import 'package:admin_panel/views/widgets/client_item/add_client.dart';
import 'package:admin_panel/views/widgets/client_item/client_item.dart';
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
        future: cilentsController.clientsHttpService.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Image.asset('assets/gifs/loading.gif'),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Malumot mavjud emas"),
            );
          }

          return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ClientItem(client: snapshot.data![index]);
              });
        },
      ),
      floatingActionButton: AddClient(),
    );
  }
}
