import 'package:ecommerce/Screens/UserScreens/Registration.dart';
import 'package:ecommerce/SharedWidgets/shared_Methods.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/databaseHelper/auth_Helper.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'UserLoginScreen';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginScreen({super.key});

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
                      text: 'Login',
                      onTap: () {
                        _emailController.text.trim().isEmpty ||
                                _passwordController.text.trim().isEmpty
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                snackBar('Please Fill all The Fields!'))
                            : AuthHelper().userLogin(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                context: context);
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: priceTextStyle,
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RegistrationScreen.id);
                        },
                        child: Text(
                          'Sign Up',
                          style: priceTextStyle.copyWith(
                              fontWeight: FontWeight.bold, color: brandColor),
                        ),
                      )
                    ],
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
