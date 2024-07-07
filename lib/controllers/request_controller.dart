import 'dart:convert';
import 'dart:io';
import 'package:admin_panel/models/reques.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

class RequestController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  Future<bool> isStirUnique(String stir) async {
    final url = Uri.parse(
        'https://savdosanoatapp-default-rtdb.firebaseio.com/clients.json?orderBy="stir"&equalTo=$stir');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data.isEmpty;
    } else {
      throw Exception('Failed to check STIR uniqueness');
    }
  }

  Future<void> addRequest(Request request) async {
    List<String> imageUrls = [];
    for (var imageFile in request.imageUrls) {
      String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${imageFile.split('/').last}';
      Reference storageReference = storage.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(File(imageFile));
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }

    await firestore.collection('requests').add({
      'username': request.username,
      'adminId': request.adminId,
      'stir': request.stir,
      'description': request.description,
      'images': imageUrls,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
