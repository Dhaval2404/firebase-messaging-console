import 'package:flutter/material.dart';

import '../../res/theme.dart';

// ignore: prefer_mixin
class ThemeNotifier with ChangeNotifier {

  bool _darkTheme = false;

  bool get isDarkTheme => _darkTheme;

  set isDarkTheme(bool value) {
    _darkTheme = value;
    notifyListeners();
  }

  ThemeMode themeMode() => _darkTheme ? ThemeMode.dark : ThemeMode.light;

  ThemeData theme() =>
      _darkTheme ? darkTheme : lightTheme;
}
