import 'package:ecommerce/Screens/UserScreens/shared_OrderCartContainer.dart';
import 'package:ecommerce/SharedWidgets/shared_Methods.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class OrderStatusPage extends StatelessWidget {
  OrderStatusPage({super.key, required this.orderStatus, required this.snap});
  var snap;
  List<String> orderCheck = [
    'requested',
    'accepted',
    'ontheway',
    'delivered',
    'canceled'
  ];
  String orderStatus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sharedAppBar(context, title: 'Order Status'),
      body: SafeArea(
        child: sharedCircularPadding(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SharedOrderCartContainer(
                  snap: snap,
                  containerheight: 170,
                  paymentMode: Text(
                    'Payment: ${snap['paymentoption'].toString().toUpperCase()}',
                    style: priceTextStyle,
                  ),
                  deliverySatus: Text(
                    'Status: ${snap['orderstatus'].toString().toUpperCase()}',
                    style: priceTextStyle.copyWith(color: brandColor),
                  ),
                ),
                sharedCircularPadding(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRow('Requested', 0),
                        buildSizedBox(1),
                        buildRow('Accepted', 1),
                        buildSizedBox(2),
                        buildRow('On the Way', 2),
                        buildSizedBox(3),
                        buildRow('Delivered', 3),
                        buildSizedBox(4),
                        buildRow('Canceled', 4),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildRow(String text, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.circle_sharp,
          color: orderStatus == orderCheck[4]
              ? index <= 4
                  ? brandColor
                  : Colors.grey
              : orderStatus == orderCheck[3]
                  ? index <= 3
                      ? brandColor
                      : Colors.grey
                  : orderStatus == orderCheck[2]
                      ? index <= 2
                          ? brandColor
                          : Colors.grey
                      : orderStatus == orderCheck[1]
                          ? index <= 1
                              ? brandColor
                              : Colors.grey
                          : orderStatus == orderCheck[0]
                              ? index <= 0
                                  ? brandColor
                                  : Colors.grey
                              : Colors.grey,
        ),
        Text(text, style: priceTextStyle.copyWith(color: brandColor)),
      ],
    );
  }

  SizedBox buildSizedBox(int index) {
    return SizedBox(
        height: 45,
        child: VerticalDivider(
          width: 25,
          thickness: 4,
          color: orderStatus == orderCheck[4]
              ? index <= 4
                  ? brandColor
                  : Colors.grey
              : orderStatus == orderCheck[3]
                  ? index <= 3
                      ? brandColor
                      : Colors.grey
                  : orderStatus == orderCheck[2]
                      ? index <= 2
                          ? brandColor
                          : Colors.grey
                      : orderStatus == orderCheck[1]
                          ? index <= 1
                              ? brandColor
                              : Colors.grey
                          : Colors.grey,
        ));
  }
}
