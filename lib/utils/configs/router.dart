import 'package:volo_consumer/screens/home/home_screen.dart';
import 'package:volo_consumer/screens/intro/intro_screen.dart';
import 'package:volo_consumer/screens/login/login_screen.dart';
import 'package:volo_consumer/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

//TODO: reove redundant code by making proper error screen

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    var args = routeSettings.arguments;
    switch (routeSettings.name) {
      case "/intro":
        return MaterialPageRoute(builder: (_) => const IntroScreen());

      case "/login":
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case "/home":
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case "/profile":
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => ProfileScreen(profileID: args));
        } else {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text(
                    'No route defined for ${routeSettings.name} or invalid args'),
              ),
            ),
          );
        }

      case "/error":
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text("Error : $args"),
              ),
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text(
                    'No route defined for ${routeSettings.name} or invalid args'),
              ),
            ),
          );
        }

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}
