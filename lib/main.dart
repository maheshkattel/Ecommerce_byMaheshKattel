import 'package:ecommerce/Provider/provider.dart';
import 'package:ecommerce/Screens/ShopUserScreens/items_Page.dart';
import 'package:ecommerce/Screens/ShopUserScreens/shop_LoginScreen.dart';
import 'package:ecommerce/Screens/UserScreens/Registration.dart';
import 'package:ecommerce/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/ShopUserScreens/add_ItemsPage.dart';
import 'Screens/UserScreens/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBb9OhpkDWf44xJit5QOy1wT8qM9BMks2E',
          appId: '1:4546120271:android:160795c56d51132930b83a',
          messagingSenderId: '4546120271',
          projectId: 'ecommerce-c92e3',
          storageBucket: 'ecommerce-c92e3.appspot.com'));
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => EcommerceProvider(),
      )
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.id,
      routes: {
        ShopLoginScreen.id: (context) => const ShopLoginScreen(),
        AddItemsPage.id: (context) => const AddItemsPage(),
        ItemsPage.id: (context) => const ItemsPage(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen()
      },
      title: 'E-Commerce',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
            .copyWith(background: backgroundColor),
      ),
      home: const ShopLoginScreen(),
    );
  }
}
