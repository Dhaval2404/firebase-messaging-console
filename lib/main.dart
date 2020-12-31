import 'package:firebase_messaging_tester/src/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase FCM Tester',
      theme: ThemeData(
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
      ),
      home: MainScreen(),
    );
  }
}
