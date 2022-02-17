import 'package:flutter/material.dart';
import 'package:news_demo/SplashScreen/splash_screen.dart';
import 'package:news_demo/SplashScreen/login_screen.dart';
import 'package:news_demo/SplashScreen/home_screen.dart';

bool isSpinnerLoading = false;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News Reader App',
        home: SplashScreen(
          seconds: 0,
          title: const Text(
            'Evoke',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        routes: {
          //All Screen routes must be defined here
          'route_login': (BuildContext context) => LoginScreen(),

          'home_screen': (BuildContext context) => Home(),
        });
  }
}
