import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Screens/UserScreens/shared_OrderCartContainer.dart';
import 'package:ecommerce/SharedWidgets/shared_Methods.dart';
import 'package:ecommerce/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List<String> paymentOptions = ['cash On Delivery', 'card'];

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedAppBar(context, title: 'My Cart'),
      body: SafeArea(
        child: sharedPadding(
          padding: 15,
          child: Column(
            children: [
              SizedBoxTen,
              const SharedOrderCartDetails(),
            ],
          ),
        ),
      ),
    );
  }
}

class SharedOrderCartDetails extends StatelessWidget {
  const SharedOrderCartDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('cart')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var snap = snapshot.data!.docs.toList()[index];
                    return Column(
                      children: [
                        SharedOrderCartContainer(
                          snap: snap,
                          containerheight: 116,
                          deliverySatus: const SizedBox(),
                          paymentMode: const SizedBox(),
                        ),
                        sharedButton(
                          text: 'Proceed To CheckOut',
                          onTap: () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: true, // user must tap button!
                              builder: (BuildContext context) {
                                return PaymentDialogBox(
                                  index: index,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                )
              : Center(
                  child: Text(
                  'Cart is Empty',
                  style: nameTextStyle,
                ));
        },
      ),
    );
  }
}

class PaymentDialogBox extends StatefulWidget {
  PaymentDialogBox({super.key, required this.index});
  int index;
  @override
  State<PaymentDialogBox> createState() => _PaymentDialogBoxState();
}

class _PaymentDialogBoxState extends State<PaymentDialogBox> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _selectedPaymentOption = paymentOptions[0];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Select Payment Options:',
        style: priceTextStyle,
      ),
      actions: <Widget>[
        ListTile(
          title: const Text('Cash on Delivery'),
          leading: Radio<String>(
            value: paymentOptions[0],
            groupValue: _selectedPaymentOption,
            onChanged: (String? value) {
              setState(() {
                _selectedPaymentOption = value!;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Credit/ Debit Cards'),
          leading: Radio<String>(
            value: paymentOptions[1],
            groupValue: _selectedPaymentOption,
            onChanged: (String? value) {
              setState(() {
                _selectedPaymentOption = value!;
              });
            },
          ),
        ),
        TextButton(
          child: Text(
            'Order Now',
            style: priceTextStyle.copyWith(color: brandColor),
          ),
          onPressed: () async {
            try {
              var snapshot = await _firestore
                  .collection('users')
                  .doc(_auth.currentUser!.uid)
                  .collection('cart')
                  .get();
              var data;

              for (var i = 0; i < snapshot.docs.length; i++) {
                data = snapshot.docs.toList()[widget.index];

                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('cart')
                    .doc(data.id)
                    .delete();
              }
              await _firestore.collection('orders').doc().set(<String, dynamic>{
                'orderby': _auth.currentUser!.uid,
                'name': data['name'],
                'price': data['price'],
                'shopname': data['shopname'],
                'quantity': data['quantity'],
                'image': data['image'],
                'size': data['size'],
                'orderstatus': 'requested',
                'paymentoption': _selectedPaymentOption.toString()
              });
              Navigator.of(context).pop();
            } catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(snackBar(e.toString()));
            }
          },
        ),
      ],
    );
  }
}
