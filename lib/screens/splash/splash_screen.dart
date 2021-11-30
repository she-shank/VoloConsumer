import 'package:flutter/material.dart';

//TODO: screenutil

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffe1f5fe),
      body: Center(
        child: FlutterLogo(
          size: 50,
        ),
      ),
    );
  }
}
