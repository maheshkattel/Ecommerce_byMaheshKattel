import 'package:ecommerce/Provider/provider.dart';
import 'package:ecommerce/Screens/ShopUserScreens/items_Page.dart';
import 'package:ecommerce/Screens/ShopUserScreens/shop_OrderPage.dart';
import 'package:ecommerce/SharedWidgets/shared_Methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class ShopDrawer extends StatelessWidget {
  const ShopDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EcommerceProvider>(context);
    return Drawer(
      backgroundColor: brandColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBoxTen,
            CircleAvatar(
              radius: 40,
              backgroundColor: whiteColor.withOpacity(0.6),
              child: const Icon(Icons.person, size: 56),
            ),
            Text(
              'Logged in as: ${provider.shopEmail}',
              style: priceTextStyle.copyWith(color: whiteColor),
            ),
            SizedBoxTen,
            sharedDrawerContainer(
                text: 'My Items',
                onTap: () {
                  Navigator.pushNamed(context, ItemsPage.id);
                }),
            SizedBoxTen,
            sharedDrawerContainer(
                text: 'My Orders',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShopOrderPage(),
                      ));
                })
          ],
        ),
      ),
    );
  }
}
