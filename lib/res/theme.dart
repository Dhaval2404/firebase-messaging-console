import 'package:flutter/material.dart';

class AppTheme {
  static TextStyle tileTitle(BuildContext context) {
    return Theme.of(context).textTheme.subtitle2.copyWith(
          fontWeight: FontWeight.bold,
        );
  }
}
