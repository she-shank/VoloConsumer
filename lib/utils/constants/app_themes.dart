import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();
  static AppThemes instance = AppThemes._();

  static final Map<AppTheme, ThemeData> appThemeData = {
    AppTheme.lightTheme: ThemeData(
      scaffoldBackgroundColor: Colors.grey,
      primaryColor: Colors.white,
      backgroundColor: Colors.red,
      accentColor: Colors.amberAccent,
      appBarTheme: AppBarTheme(
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.yellow,
        ),
      ),
    ),
    AppTheme.darkTheme: ThemeData(
      scaffoldBackgroundColor: Colors.grey,
      primarySwatch: Colors.teal,
      backgroundColor: Colors.black,
      accentColor: Colors.amberAccent,
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
        ),
      ),
    )
  };
}

enum AppTheme {
  lightTheme,
  darkTheme,
}
