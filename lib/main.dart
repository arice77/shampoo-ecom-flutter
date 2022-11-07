import 'package:ecom/screens/auth_screen.dart';
import 'package:ecom/screens/homw_scree.dart';
import 'package:ecom/screens/orders_screen.dart';
import 'package:ecom/screens/product_scren.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeNmae: (context) => const HomeScreen(),
        ProductScreen.routeNmae: ((context) => ProductScreen()),
        OrdersScreen.routeName: (context) => OrdersScreen(),
      },
      home: firebaseAuth.currentUser == null
          ? const AuthScreen()
          : const HomeScreen(),
    );
  }
}
