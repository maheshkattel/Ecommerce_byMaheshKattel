import 'package:ecommerce/Screens/UserScreens/LoginScreen.dart';
import 'package:ecommerce/SharedWidgets/shared_Methods.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/databaseHelper/auth_Helper.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  static String id = 'UserSignupScreen';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 150,
                      child: Image.asset('assets/images/icon.png')),
                  SizedBoxTen,
                  TextField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration,
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
                      text: 'Sign Up',
                      onTap: () {
                        _emailController.text.trim().isEmpty ||
                                _passwordController.text.trim().isEmpty
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                snackBar('Please Fill all The Fields!'))
                            : AuthHelper().userSignUp(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                context: context);
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an account?',
                        style: priceTextStyle,
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text(
                          'Login',
                          style: priceTextStyle.copyWith(
                              fontWeight: FontWeight.bold, color: brandColor),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
