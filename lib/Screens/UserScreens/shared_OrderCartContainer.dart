import 'package:flutter/material.dart';

import '../../constants.dart';

class SharedOrderCartContainer extends StatelessWidget {
  SharedOrderCartContainer(
      {super.key,
      required this.snap,
      required this.containerheight,
      this.paymentMode,
      this.deliverySatus});

  final snap;
  double containerheight;
  Widget? deliverySatus;
  Widget? paymentMode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: brandColor, width: 2)),
        height: containerheight,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                image: DecorationImage(
                    image: NetworkImage(
                      snap['image'],
                    ),
                    fit: BoxFit.fill),
              ),
              width: 100,
            ),
            Expanded(
              child: sharedPadding(
                padding: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snap['name'],
                      style: nameTextStyle,
                    ),

                    Text(
                      'NRs. ${snap['price']}',
                      style: priceTextStyle,
                    ),
                    Text(
                      'Qty: ${snap['quantity']}',
                      style: priceTextStyle,
                    ),
                    Text(
                      'Size: ${snap['size']}',
                      style: priceTextStyle,
                    ),
                    // Text(
                    //   'Payment Option: ${snap['paymentoption']}',
                    //   style: priceTextStyle,
                    // ),
                    paymentMode!,
                    deliverySatus!,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
