import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white,
    focusColor: Colors.grey.shade300,
    brightness: Brightness.light,
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        color: Colors.black,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(
        color: Colors.blue,
      ),
      focusColor: Colors.blue,
      activeIndicatorBorder: BorderSide(
        color: Colors.blue,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
        ),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.blue,
      selectionColor: Colors.blue,
      selectionHandleColor: Colors.blue,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    focusColor: Colors.grey.shade800,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(
        color: Colors.blue,
      ),
      focusColor: Colors.blue,
      activeIndicatorBorder: BorderSide(
        color: Colors.blue,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
        ),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.blue,
      selectionColor: Colors.blue,
      selectionHandleColor: Colors.blue,
    ),
  );
}
