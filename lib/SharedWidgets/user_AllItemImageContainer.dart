import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class UserAllItemContainer extends StatelessWidget {
  const UserAllItemContainer({
    super.key,
    required this.snap,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>>? snap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 180,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              snap?['image'],
            ),
            fit: BoxFit.cover),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: brandColor,
      ),
    );
  }
}
