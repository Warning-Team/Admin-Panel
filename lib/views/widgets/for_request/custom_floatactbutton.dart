import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CustomFloatactbutton extends StatefulWidget {
  const CustomFloatactbutton({super.key});

  @override
  State<CustomFloatactbutton> createState() => _CustomFloatactbuttonState();
}

class _CustomFloatactbuttonState extends State<CustomFloatactbutton> {
  List<File> imageFiles = [];
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  Future<void> getImageFromCamera() async {
    if (imageFiles.length < 6) {
      final XFile? imageCamera =
          await _picker.pickImage(source: ImageSource.camera);
      if (imageCamera != null) {
        setState(() {
          imageFiles.add(File(imageCamera.path));
        });
      }
    }
  }

  Future<void> getImageFromGallery() async {
    if (imageFiles.length < 6) {
      final XFile? imageGallery =
          await _picker.pickImage(source: ImageSource.gallery);
      if (imageGallery != null) {
        setState(() {
          imageFiles.add(File(imageGallery.path));
        });
      }
    }
  }

  void removeImage(int index) {
    setState(() {
      imageFiles.removeAt(index);
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.cancel,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: "User name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _userIdController,
                    decoration: InputDecoration(
                      hintText: "User ID",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 20.w,
                runSpacing: 20.h,
                children: [
                  for (int i = 0; i <= imageFiles.length; i++)
                    i == imageFiles.length && imageFiles.length < 6
                        ? InkWell(
                            onTap: () async {
                              await getImageFromCamera();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              height: 100.h,
                              width: 100.w,
                              alignment: Alignment.center,
                              child: const Icon(Icons.add_a_photo),
                            ),
                          )
                        : i < imageFiles.length
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(
                                      imageFiles[i],
                                      height: 100.h,
                                      width: 100.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () {
                                        removeImage(i);
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.remove_circle,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
