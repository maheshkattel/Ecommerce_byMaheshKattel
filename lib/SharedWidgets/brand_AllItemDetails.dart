import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class BrandAllItemDetails extends StatelessWidget {
  const BrandAllItemDetails({
    super.key,
    required this.snap,
    required this.category,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>>? snap;
  final String category;

  @override
  Widget build(BuildContext context) {
    return sharedPadding(
      padding: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(
                'assets/images/${snap!['brandname'].toString().toLowerCase()}.png'),
          ),
          Text(
            snap!['name'],
            style: nameTextStyle,
          ),
          Text(
            'NRs. ${snap!['price']}',
            style: priceTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            '${snap!['shopname']}',
            style: priceTextStyle,
          ),
        ],
      ),
    );
  }
}
