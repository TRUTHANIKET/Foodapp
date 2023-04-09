import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethod {
  Future<void> addData(foodData) async {
    FirebaseFirestore.instance
        .collection("blogs")
        .add(foodData)
        .catchError((e) {
      print(e);
    });
    ;
  }

  Getdata() async {
    return await FirebaseFirestore.instance.collection('blogs').get();
  }
}
