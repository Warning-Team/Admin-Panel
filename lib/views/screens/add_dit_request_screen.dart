import 'dart:io';
import 'package:admin_panel/services/http_services/request_http_serrvice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:admin_panel/models/request.dart';

class AddEditRequestScreen extends StatefulWidget {
  final Request? request;

  const AddEditRequestScreen({Key? key, this.request}) : super(key: key);

  @override
  _AddEditRequestScreenState createState() => _AddEditRequestScreenState();
}

class _AddEditRequestScreenState extends State<AddEditRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final RequestsHttpService _requestsHttpService = RequestsHttpService();

  late int _id;
  late int _eId;
  late int _cId;
  late DateTime _date;
  late String _description;
  late List<String> _imgUrls;

  File? _image; // Variable to store the selected image

  @override
  void initState() {
    super.initState();
    if (widget.request != null) {
      _id = widget.request!.id;
      _eId = widget.request!.eId;
      _cId = widget.request!.cId;
      _date = widget.request!.date;
      _description = widget.request!.description;
      _imgUrls = widget.request!.imgUrls;
    } else {
      _id = 0;
      _eId = 0;
      _cId = 0;
      _date = DateTime.now();
      _description = '';
      _imgUrls = [];
    }
  }

  void _saveRequest() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final request = Request(
        id: _id,
        eId: _eId,
        cId: _cId,
        date: _date,
        description: _description,
        imgUrls: _imgUrls,
      );

      if (widget.request == null) {
        _requestsHttpService.addRequest(request);
      } else {
        _requestsHttpService.updateRequest(
            widget.request!.id.toString(), request);
      }

      Navigator.pop(context);
    }
  }

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imgUrls.add(pickedFile.path); // Add image path to the list
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.request == null ? 'Add Request' : 'Edit Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _id.toString(),
                decoration: InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _id = int.parse(value!),
              ),
              TextFormField(
                initialValue: _eId.toString(),
                decoration: InputDecoration(labelText: 'Employee ID'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _eId = int.parse(value!),
              ),
              TextFormField(
                initialValue: _cId.toString(),
                decoration: InputDecoration(labelText: 'Client ID'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _cId = int.parse(value!),
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _getImage, // Call _getImage method on button press
                child: Text('Select Image'),
              ),
              SizedBox(height: 16),
              if (_image != null)
                Image.file(_image!), // Display selected image if available
              ElevatedButton(
                onPressed: _saveRequest,
                child: Text(widget.request == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
