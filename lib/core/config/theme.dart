import 'package:baredex/core/config/config.dart';
import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  fontFamily: 'Montserrat',
  primaryColor: Colors.white,
  accentColor: baredexBlue,
  brightness: Brightness.light,
  primaryColorBrightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFE9E9E9),
  backgroundColor: Color(0xFFFFFFFF),
  appBarTheme: AppBarTheme(
    color: Colors.indigo,
    brightness: Brightness.dark,
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
    },
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w500,
    ),
    focusColor: Colors.grey,
    hintStyle: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w500,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      borderSide: BorderSide(
        width: 20,
        color: Colors.grey,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.grey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.grey,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Colors.grey,
      ),
    ),
  ),
);
