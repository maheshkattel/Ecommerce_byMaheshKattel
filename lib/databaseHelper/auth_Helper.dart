// ignore_for_file: unrelated_type_equality_checks
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../Screens/ShopUserScreens/add_ItemsPage.dart';
import '../Screens/UserScreens/home_Page.dart';
import '../constants.dart';

class AuthHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Shop Login
  shopLogin(
      {required String email,
      required String password,
      required context}) async {
    showDialog(
        context: context,
        builder: (context) => Center(
                child: CircularProgressIndicator(
              color: brandColor,
              strokeWidth: 5,
            )));
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != "") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddItemsPage()));
      }
    } catch (e) {
      if (kDebugMode) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(snackBar(e.toString()));
      }
    }
  }

//User SignUp
  userSignUp(
      {required String email,
      required String password,
      required context}) async {
    showDialog(
        context: context,
        builder: (context) => Center(
                child: CircularProgressIndicator(
              color: brandColor,
              strokeWidth: 5,
            )));
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set(<String, dynamic>{
        'email': email,
        'uid': _auth.currentUser!.uid,
      });
      if (user != "") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } catch (e) {
      if (kDebugMode) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(snackBar(e.toString()));
      }
    }
  }

//User Login
  userLogin(
      {required String email,
      required String password,
      required context}) async {
    showDialog(
        context: context,
        builder: (context) => Center(
                child: CircularProgressIndicator(
              color: brandColor,
              strokeWidth: 5,
            )));
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (user != "") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } catch (e) {
      if (kDebugMode) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(snackBar(e.toString()));
      }
    }
  }
}
