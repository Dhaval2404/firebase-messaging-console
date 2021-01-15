import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  accentColor: Colors.blue,
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[800], width: 2.0),
      borderRadius: BorderRadius.circular(0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[300], width: 2.0),
      borderRadius: BorderRadius.circular(0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red[500], width: 2.0),
      borderRadius: BorderRadius.circular(0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red[500], width: 2.0),
      borderRadius: BorderRadius.circular(0),
    ),
  ),
  buttonColor: Colors.blue,
  buttonTheme: ButtonThemeData(
    height: 48,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.grey[100],
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.grey[800]),
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.grey[850],
  brightness: Brightness.dark,
  backgroundColor: Colors.grey[850],
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200], width: 2.0),
      borderRadius: BorderRadius.circular(0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[600], width: 2.0),
      borderRadius: BorderRadius.circular(0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red[500], width: 2.0),
      borderRadius: BorderRadius.circular(0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red[500], width: 2.0),
      borderRadius: BorderRadius.circular(0),
    ),
  ),
  buttonColor: Colors.grey,
  buttonTheme: ButtonThemeData(
    height: 48,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.grey[800],
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(),
);
