import 'dart:convert';
import 'dart:io';
import 'package:admin_panel/models/request.dart';
import 'package:admin_panel/utils/extentions/datetime_reformat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestController extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance.collection('requests');

  Stream<QuerySnapshot<Map<String, dynamic>>> getReusets() {
    return firestore.orderBy('date', descending: true).snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRequestsFuture() {
    return firestore.orderBy('date', descending: true).get();
  }

  checkClient(String stir) async {
    final url = Uri.parse(
        'https://savdosanoatapp-default-rtdb.firebaseio.com/clients.json?orderBy="stir"&equalTo=$stir');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map;

      if (data.isNotEmpty) {
        return {
          'isFind': true,
          'status': data,
        };
      } else {
        return {
          'isFind': false,
          'status': 'Malumot topilmadi',
        };
      }
    } else {
      return {
        'isFind': false,
        'status': 'Check your internet',
      };
    }
  }

  Stream<TaskSnapshot> addImageToFirestore(
      List<File> imageFiles, String companyName, String employeName) async* {
    final fireStore = FirebaseStorage.instance;
    final imagePath = fireStore
        .ref()
        .child('requests')
        .child(companyName)
        .child("${DateTime.now().toFormattedDate()} $employeName");
    for (var i = 0; i < imageFiles.length; i++) {
      final uploadTask = imagePath.child("image$i.jpg").putFile(imageFiles[i]);
      yield* uploadTask.snapshotEvents;
    }
  }

  Future<void> saveRequestToFirestore(Request request) async {
    await firestore.add(request.toMap());
  }

  static getClientName(int cId) async {
    // ignore: unused_local_variable
    final url = Uri.parse(
        'https://savdosanoatapp-default-rtdb.firebaseio.com/clients.json?orderBy="id"&equalTo=$cId');
    return "";
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getRequests(int eId) {
    final firestore = FirebaseFirestore.instance.collection('requests');

    return firestore
        .where('eId', isEqualTo: eId)
        .orderBy('date', descending: true)
        .snapshots();
  }
}
