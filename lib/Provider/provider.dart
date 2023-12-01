import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EcommerceProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<String> shopCategory = [];
  List<String> userCategory = [];
  List<String> brandCategory = [];
  String userEmail = '';
  String shopName = '';
  String shopAddress = '';
  String shopContact = '';
  String shopEmail = '';

  //get user details
  getUserDetails() async {
    try {
      var userSnap =
          await firestore.collection('users').doc(auth.currentUser?.uid).get();
      var data = userSnap.data();
      userEmail = data!['email'];
      notifyListeners();
    } catch (e) {}
  }
  //get shop category

  getShopCategory() async {
    try {
      // get Shop Details
      var shopSnap = await firestore
          .collection('shopdetails')
          .doc(auth.currentUser?.uid)
          .get();
      var shopData = shopSnap.data();
      shopName = shopData!['name'];
      shopAddress = shopData['address'];
      shopContact = shopData['contact'];
      shopEmail = shopData['email'];
      notifyListeners();

      // get Category
      var snap = await firestore
          .collection('shopdetails')
          .doc(auth.currentUser?.uid)
          .collection('myitems')
          .get();

      var data = snap.docs.toList();
      for (var i = 0; i < data.length; i++) {
        if (shopCategory.contains(data[i]['category'])) {
        } else {
          shopCategory.add(data[i]['category']);
        }
        notifyListeners();
      }
    } catch (e) {}
  }

  //get User Category
  getUserCategory() async {
    try {
      var snap = await firestore.collection('categories').get();
      var data = snap.docs.map((e) => e.id).toList();
      for (var i = 0; i < snap.docs.length; i++) {
        userCategory.add(data[i]);
        notifyListeners();
      }
    } catch (e) {}
  }

  getBrandCategory() async {
    try {
      var snap = await firestore.collection('brands').get();
      var data = snap.docs.map((e) => e.id).toList();
      for (var i = 0; i < snap.docs.length; i++) {
        brandCategory.add(data[i]);
        notifyListeners();
      }
    } catch (e) {}
  }
}
