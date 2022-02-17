import 'dart:async';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../SplashScreen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  final int seconds;
  final Text title;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  final dynamic navigateAfterSeconds;
  final dynamic onClick;
  final Color loaderColor;
  final Image image;
  final Text loadingText;
  final Text bottomText;
  final ImageProvider backgroundImage;
  final Gradient backgroundGradient;
  final Color themeColor;

  const SplashScreen(
      {this.loaderColor,
      @required this.seconds,
      this.onClick,
      this.navigateAfterSeconds,
      this.title = const Text(''),
      this.backgroundColor = Colors.white,
      this.styleTextUnderTheLoader = const TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
      this.image,
      this.loadingText,
      this.bottomText,
      this.backgroundImage,
      this.backgroundGradient,
      this.themeColor});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initRouting();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  // Custom Android device back button action
  Future<bool> _willPop() {}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark));
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(children: [
            Container(
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [Colors.blue, Colors.pink],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    showLogo(),
                  ],
                ))),
            Visibility(
              visible: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 150, top: 50),
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            )
          ])),
    );
  }

  /**
   * Displays evoke logo in Splash screen
   */
  Widget showLogo() {
    return Container(
      alignment: Alignment.center,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'News Reader App',
            style: TextStyle(fontSize: 25),
          )
        ],
      ),
    );
  }

  initRouting() async {
    Timer(Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacementNamed("route_login");
    });
  }
  /**
   * It's used to check network connection, if there is no network it pop's up
   * a message that dis
   */

  /**
   * This method checks whether it is first time login or not.
   * If it is first login, it navigates to Add EV Screen where EV details will be added.
   * If it is not first login, it navigates to Home Screen (Maps)
   */

  /**
   * Initialize the routing based on stored session, if session is saved then it calls api
   * for fetching charge activity status or else it routes to landing screen.
   */

  /**
   * It navigates to specific screen based on screen name
   */

}
