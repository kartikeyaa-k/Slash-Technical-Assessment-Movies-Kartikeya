import 'package:flutter/material.dart';

// Have not addded much but need to utilize from here.
class AppTheme {
  static ThemeData get light {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,
        splashColor: Colors.transparent,
        fontFamily: 'IBM',
        textTheme: const TextTheme(
          button: TextStyle(),
          caption: TextStyle(),
          overline: TextStyle(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        )));
  }
}
