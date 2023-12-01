import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Screens/UserScreens/order_StatusPage.dart';
import 'package:ecommerce/Screens/UserScreens/shared_OrderCartContainer.dart';
import 'package:ecommerce/SharedWidgets/shared_Methods.dart';
import 'package:ecommerce/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedAppBar(context, title: 'My Orders'),
      body: SafeArea(
        child: sharedPadding(
          padding: 10,
          child: Column(
            children: [
              SizedBoxTen,
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('orders')
                      .where('orderby',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var snap = snapshot.data!.docs.toList()[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderStatusPage(
                                            snap: snap,
                                            orderStatus: snap['orderstatus']),
                                      ));
                                },
                                child: SharedOrderCartContainer(
                                  snap: snap,
                                  containerheight: 170,
                                  paymentMode: Text(
                                    'Payment: ${snap['paymentoption'].toString().toUpperCase()}',
                                    style: priceTextStyle,
                                  ),
                                  deliverySatus: Text(
                                    'Status: ${snap['orderstatus'].toString().toUpperCase()}',
                                    style: priceTextStyle.copyWith(
                                        color: brandColor),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'No Orders Yet',
                              style: priceTextStyle,
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
