import 'dart:io';
import 'package:admin_panel/controllers/request_controller.dart';
import 'package:admin_panel/models/reques.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFloatactbutton extends StatefulWidget {
  const CustomFloatactbutton({Key? key}) : super(key: key);

  @override
  State<CustomFloatactbutton> createState() => _CustomFloatactbuttonState();
}

class _CustomFloatactbuttonState extends State<CustomFloatactbutton> {
  final RequestController _requestController = RequestController();
  List<File> imageFiles = [];
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _stirController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? usernameError;
  String? userIdError;
  String? stirError;
  String? descriptionError;

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();

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
    _stirController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate() &&
        descriptionError == null &&
        stirError == null) {
      setState(() {
        isLoading = true;
      });
      try {
        // Create request object
        Request request = Request(
          username: _usernameController.text,
          adminId: _userIdController.text,
          stir: _stirController.text,
          description: _descriptionController.text,
          imageUrls: imageFiles.map((file) => file.path).toList(),
        );

        // Add request to Firestore
        await _requestController.addRequest(request);

        // Clear the form after successful submission
        _usernameController.clear();
        _userIdController.clear();
        _stirController.clear();
        _descriptionController.clear();
        setState(() {
          imageFiles.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request added successfully')),
        );
      } catch (e) {
        print('Error saving data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving data: $e')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _showPickerOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Photo Library'),
                  onTap: () {
                    getImageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    getImageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void checkStirUniqueness(String stir) async {
    try {
      bool isUnique = await _requestController.isStirUnique(stir);
      setState(() {
        stirError = isUnique ? null : "STIR already exists";
      });
    } catch (e) {
      print('Error checking STIR uniqueness: $e');
      setState(() {
        stirError = "Failed to check STIR uniqueness";
      });
    }
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
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    errorText: usernameError,
                    border: OutlineInputBorder(),
                    labelText: "User name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "User name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                TextFormField(
                  controller: _userIdController,
                  decoration: InputDecoration(
                    errorText: userIdError,
                    border: OutlineInputBorder(),
                    labelText: "Admin ID",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Admin ID is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                TextFormField(
                  controller: _stirController,
                  decoration: InputDecoration(
                    errorText: stirError,
                    border: OutlineInputBorder(),
                    labelText: "STIR",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "STIR is required";
                    } else if (int.tryParse(value) == null) {
                      return "Invalid STIR format";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      stirError = null; // Reset error on change
                    });
                    if (value.isNotEmpty) {
                      checkStirUniqueness(value);
                    }
                  },
                ),
                SizedBox(height: 15.h),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    errorText: descriptionError,
                    border: OutlineInputBorder(),
                    hintText: "Description",
                  ),
                  minLines: 3,
                  maxLines: 5,
                  maxLength: 300,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                Wrap(
                  spacing: 20.w,
                  runSpacing: 20.h,
                  children: [
                    for (int i = 0; i <= imageFiles.length; i++)
                      i == imageFiles.length && imageFiles.length < 6
                          ? InkWell(
                              onTap: () => _showPickerOptions(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 5.w,
                                  ),
                                  borderRadius: BorderRadius.circular(15.w),
                                ),
                                height: 100.h,
                                width: 100.w,
                                alignment: Alignment.center,
                                child: Icon(Icons.add_a_photo),
                              ),
                            )
                          : i < imageFiles.length
                              ? Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.w),
                                      child: Image.file(
                                        imageFiles[i],
                                        height: 100.h,
                                        width: 100.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 5.h,
                                      right: 5.w,
                                      child: GestureDetector(
                                        onTap: () {
                                          removeImage(i);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.remove_circle,
                                            color: Colors.white,
                                            size: 20.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                  ],
                ),
                SizedBox(height: 15.h),
                SizedBox( 
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                    ),
                    onPressed: isLoading ? null : submit,
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
