import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class UploadtoStorage {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  File image;
  UploadtoStorage({required this.image});

  addItems(
      {required String name,
      required String brandName,
      required List size,
      required int price,
      required String sex,
      required String category,
      required String description,
      required File image}) async {
    var snap = await _firestore
        .collection('shopdetails')
        .where('uid', isEqualTo: _auth.currentUser!.uid)
        .get();
    var data = snap.docs[0];
    TaskSnapshot emage = await uploadPhoto();
    try {
      await _firestore
          .collection('categories')
          .doc(category.toLowerCase())
          .collection(category.toLowerCase())
          .add(<String, dynamic>{
        'name': name,
        'price': price,
        'brandname': brandName,
        'size': size,
        'category': category,
        'description': description,
        'sex': sex.toLowerCase(),
        'shopname': data['name'],
        'image': await emage.ref.getDownloadURL()
      });

      await _firestore
          .collection('brands')
          .doc(brandName.toLowerCase())
          .collection(brandName.toLowerCase())
          .add(<String, dynamic>{
        'name': name,
        'price': price,
        'size': size,
        'brandname': brandName,
        'category': category,
        'description': description,
        'sex': sex.toLowerCase(),
        'shopname': data['name'],
        'image': await emage.ref.getDownloadURL()
      });

      await _firestore
          .collection('shopdetails')
          .doc(_auth.currentUser!.uid)
          .collection('myitems')
          .add(<String, dynamic>{
        'name': name,
        'brananame': brandName,
        'size': size,
        'category': category.toLowerCase(),
        'price': price,
        'description': description,
        'sex': sex.toLowerCase(),
        'shopname': data['name'],
        'image': await emage.ref.getDownloadURL()
      });

      await _firestore.collection('allitems').add(<String, dynamic>{
        'name': name,
        'price': price,
        'brandname': brandName,
        'size': size,
        'category': category,
        'description': description,
        'sex': sex.toLowerCase(),
        'shopname': data['name'],
        'image': await emage.ref.getDownloadURL()
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<TaskSnapshot> uploadPhoto() async {
    return await _firebaseStorage
        .ref('images/${image.path.split('/').last}')
        .putFile(image);
  }
}
