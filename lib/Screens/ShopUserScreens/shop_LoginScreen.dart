import 'package:ecommerce/databaseHelper/auth_Helper.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/SharedWidgets/shared_Methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/provider.dart';

class ShopLoginScreen extends StatefulWidget {
  static String id = 'ShopLoginScreen';
  const ShopLoginScreen({super.key});

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    Provider.of<EcommerceProvider>(context, listen: false).getShopCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                      height: 150,
                      child: Image.asset('assets/images/icon.png')),
                  SizedBoxTen,
                  TextField(
                    controller: _emailController,
                    decoration: kTextFieldDecoration,
                    textAlign: TextAlign.center,
                  ),
                  SizedBoxTen,
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                        prefixIcon: const Icon(Icons.password_outlined),
                        hintText: 'Password Here.....'),
                  ),
                  SizedBoxTen,
                  sharedButton(
                    text: 'Login',
                    onTap: () {
                      AuthHelper().shopLogin(
                          context: context,
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim());
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
