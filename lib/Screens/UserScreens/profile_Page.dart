import 'package:ecommerce/Screens/UserScreens/LoginScreen.dart';
import 'package:ecommerce/Screens/UserScreens/cartPage.dart';
import 'package:ecommerce/SharedWidgets/shared_Methods.dart';
import 'package:ecommerce/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/provider.dart';
import 'orderPage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EcommerceProvider>(context);
    return Scaffold(
      appBar: sharedAppBar(context, title: 'Profile'),
      body: SafeArea(
        child: sharedPadding(
          padding: 15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBoxTen,
                  Center(
                      child: CircleAvatar(
                    radius: 60,
                    backgroundColor: brandColor,
                    child: Icon(
                      Icons.person,
                      size: 109,
                      color: whiteColor,
                    ),
                  )),
                  SizedBoxTen,
                  Center(
                      child: Text(
                    provider.userEmail,
                    style: nameTextStyle.copyWith(fontSize: 19),
                  )),
                  SizedBoxTen,
                  SizedBoxTen,
                  sharedListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CartPage()));
                      },
                      title: 'My Cart',
                      icon: Icons.favorite_border),
                  sharedListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OrderPage()));
                      },
                      title: 'Orders',
                      icon: Icons.shopping_bag_outlined),
                  sharedListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Just a Test App',
                                style: nameTextStyle,
                              ),
                              content: Text(
                                'Coder : Mahesh Kattel',
                                style: priceTextStyle,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Ok'))
                              ],
                            );
                          },
                        );
                      },
                      title: 'About Us',
                      icon: Icons.new_releases_outlined),
                  sharedListTile(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      title: 'Log Out',
                      icon: Icons.logout_outlined),
                ],
              ),
              Text(
                'Version 1.2.0.6',
                style: priceTextStyle.copyWith(fontStyle: FontStyle.italic),
              )
            ],
          ),
        ),
      ),
    );
  }
}
