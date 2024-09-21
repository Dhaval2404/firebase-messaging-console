import 'package:fcm_app_tester/theme/theme.dart';
import 'package:fcm_app_tester/ui/home/home_page.dart';
import 'package:flutter/material.dart';

class MessagingApp extends StatelessWidget {
  const MessagingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Messaging Console',
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}
