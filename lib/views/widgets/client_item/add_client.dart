import 'package:admin_panel/models/client.dart';
import 'package:admin_panel/services/http_services/cilents_http_service.dart';
import 'package:admin_panel/utils/inputvalidatsiya.dart';
import 'package:admin_panel/utils/make_client_to_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddClient extends StatefulWidget {
  const AddClient({super.key});

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final clientsHttpService = CilentsHttpService();
  final Client client = Client(
    id: 1,
    apiId: "apiIdClient",
    stir: 1,
    companyName: "",
    eId: 1,
    phoneNumber: "",
  );
  saveUser() async {
    try {
      final makeClient = MakeClientToAdd();
      _formKey.currentState!.save();
      Client makedClient = await makeClient.makeClient(client);
      Navigator.pop(context);
      clientsHttpService.addClient(makedClient);
      setState(() {});
     
    } catch (e) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Xatolik: $e",
                    ),
                  )
                ],
              ),
            );
          });
    }
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
                          "Add Client",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              CupertinoIcons.building_2_fill,
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'MCHJ nomi',
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !Validate.isLengthGreaterThanFour(value)) {
                              return "Kompaniya nomini to'g'ri kriting";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            client.companyName = value!;
                          },
                        ),
                        SizedBox(height: 16.h),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            
                            prefixIcon: Icon(
                              CupertinoIcons.person_fill,
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Ishchi ID si',
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !Validate.isLengthGreaterThanFive(value)) {
                              return "Hodim Id sini to'g'ri kiriting";
                            } else {
                              return null;
                            }
                          },
                          
                          onSaved: (value) {
                            client.eId = int.parse(value!);
                          },
                        ),
                         SizedBox(height: 16.h),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            
                            prefixIcon: Icon(
                              CupertinoIcons.person_fill,
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Client STIR i',
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !Validate.isLengthGreaterThan14(value)) {
                              return "Client STIR ini to'g'ri kiriting";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            client.eId = int.parse(value!);
                          },
                        ),
                        SizedBox(height: 16.h),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Telefon raqam',
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !Validate.phone(value)) {
                              return "Telefon raqam kiriting";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            client.phoneNumber = value!;
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
