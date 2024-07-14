import 'package:admin_panel/controllers/cilents_controller.dart';
import 'package:admin_panel/controllers/request_controller.dart';
import 'package:admin_panel/models/request.dart';
import 'package:admin_panel/utils/extentions/datetime_reformat.dart';
import 'package:admin_panel/views/screens/reques_screen/add_new_request.dart';
import 'package:admin_panel/views/screens/reques_screen/request_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainRequestScreen extends StatefulWidget {
  const MainRequestScreen({super.key});

  @override
  State<MainRequestScreen> createState() => _MainRequestScreenState();
}

class _MainRequestScreenState extends State<MainRequestScreen> {
  RequestController requestController = RequestController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Requests",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: requestController.getReusets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Malumot olishda hatolik"));
          }
          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("malumot mavjud emas"));
          }
          final data = snapshot.data!.docs;
          return ListView.builder(
            padding: EdgeInsets.all(10.w),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final request = Request.fromQuery(data[index]);
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequestScreen(
                            request: request,
                          ),
                        ));
                  },
                  title: FutureBuilder(
                    initialData: 'Company Name',
                    future: CilentsController.getClinetNameById(request.cId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Company Name");
                      }
                      if (snapshot.hasError || snapshot.data == null) {
                        return Text("Malumot olishda xato");
                      }

                      return Text(snapshot.data!);
                    },
                  ),
                  subtitle: Text(
                    request.date.toFormattedDate(),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewRequest()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
