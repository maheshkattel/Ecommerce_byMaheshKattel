import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class DeliveryDialogBox extends StatefulWidget {
  DeliveryDialogBox({super.key, required this.index});

  int index;

  @override
  State<DeliveryDialogBox> createState() => _DeliveryDialogBoxState();
}

List<String> deliveryOptions = [
  'requested',
  'accepted',
  'ontheway',
  'delivered',
  'canceled'
];

class _DeliveryDialogBoxState extends State<DeliveryDialogBox> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedDeliveryOption = deliveryOptions.first;
  @override
  Widget build(BuildContext context) {
    String shopname =
        Provider.of<EcommerceProvider>(context, listen: false).shopName;
    return AlertDialog(
      title: Text(
        'Update Delivery Status:',
        style: priceTextStyle,
      ),
      actions: <Widget>[
        ListTile(
          title: const Text('Requested'),
          leading: Radio<String>(
            value: deliveryOptions[0],
            groupValue: _selectedDeliveryOption,
            onChanged: (String? value) {
              setState(() {
                _selectedDeliveryOption = value!;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Accepted'),
          leading: Radio<String>(
            value: deliveryOptions[1],
            groupValue: _selectedDeliveryOption,
            onChanged: (String? value) {
              setState(() {
                _selectedDeliveryOption = value!;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('On The Way'),
          leading: Radio<String>(
            value: deliveryOptions[2],
            groupValue: _selectedDeliveryOption,
            onChanged: (String? value) {
              setState(() {
                _selectedDeliveryOption = value!;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Delivered'),
          leading: Radio<String>(
            value: deliveryOptions[3],
            groupValue: _selectedDeliveryOption,
            onChanged: (String? value) {
              setState(() {
                _selectedDeliveryOption = value!;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Canceled'),
          leading: Radio<String>(
            value: deliveryOptions[4],
            groupValue: _selectedDeliveryOption,
            onChanged: (String? value) {
              setState(() {
                _selectedDeliveryOption = value!;
              });
            },
          ),
        ),
        TextButton(
          child: Text(
            'Update',
            style: priceTextStyle.copyWith(color: brandColor),
          ),
          onPressed: () async {
            try {
              var snapshot = await _firestore
                  .collection('orders')
                  .where('shopname', isEqualTo: shopname)
                  .get();
              for (var i = 0; i < snapshot.docs.length; i++) {
                var data = snapshot.docs.toList();

                await _firestore
                    .collection('orders')
                    .doc(data[widget.index].id)
                    .update(<String, dynamic>{
                  'orderstatus': _selectedDeliveryOption.toString(),
                });
              }
              Navigator.of(context).pop();
            } catch (e) {
              if (kDebugMode) {
                print(e.toString());
              }
            }
          },
        ),
      ],
    );
  }
}
