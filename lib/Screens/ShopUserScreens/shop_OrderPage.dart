import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../SharedWidgets/shared_Methods.dart';
import '../../constants.dart';
import '../UserScreens/order_StatusPage.dart';
import '../UserScreens/shared_OrderCartContainer.dart';
import 'delivery_DialogBox.dart';

class ShopOrderPage extends StatelessWidget {
  const ShopOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    String shopName = Provider.of<EcommerceProvider>(context).shopName;
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
                      .where('shopname', isEqualTo: shopName)
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
                                child: Column(
                                  children: [
                                    SharedOrderCartContainer(
                                        paymentMode: Text(
                                          'Paid by: ' + snap['paymentoption'],
                                          style: priceTextStyle,
                                        ),
                                        snap: snap,
                                        containerheight: 191,
                                        deliverySatus: Center(
                                          child: MaterialButton(
                                              color: brandColor,
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return DeliveryDialogBox(
                                                        index: index);
                                                  },
                                                );
                                              },
                                              child: Text(
                                                snap['orderstatus']
                                                    .toString()
                                                    .toUpperCase(),
                                                style: priceTextStyle.copyWith(
                                                    color: whiteColor),
                                              )),
                                        )),
                                  ],
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
