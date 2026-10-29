import 'package:firebase_otp/config/flavors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: F.color,
      primary: F.color,
      error: Colors.red,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: F.color,
      foregroundColor: Colors.white,
    ),
  );
}
