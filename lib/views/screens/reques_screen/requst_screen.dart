import 'package:admin_panel/views/widgets/for_request/custom_floatactbutton.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Requests",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue,
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("User Name",
                                  style: TextStyle(color: Colors.white)),
                              Text("User ID",
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red.shade300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          onPressed: () {
            showCupertinoModalBottomSheet(
              context: context,
              builder: (context) {
                return CustomFloatactbutton();
              },
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
