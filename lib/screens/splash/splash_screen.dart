import 'package:flutter/material.dart';

//TODO: screenutil

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: Center(
        child: Image.asset(
          "assets/images/splash.png",
          height: 241,
          width: 189,
        ),
      ),
    );
  }
}
