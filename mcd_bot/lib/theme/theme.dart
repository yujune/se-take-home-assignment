import 'package:flutter/material.dart';
import 'package:mcd_bot/util/constant/color.dart';

class AppTheme {
  static ThemeData defaultTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ThemeData.light().colorScheme.copyWith(
          primary: AppColor.primary,
        ),
    dividerTheme: ThemeData.light().dividerTheme.copyWith(
          indent: 15,
          endIndent: 15,
          color: Colors.black12,
        ),
    textTheme: ThemeData.light().textTheme.copyWith(
          displayLarge: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 0,
          ),
          displayMedium: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 0,
          ),
          bodyLarge: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 0,
          ),
          bodyMedium: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 0,
          ),
          bodySmall: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            letterSpacing: 0,
          ),
          labelSmall: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            letterSpacing: 0,
          ),
        ),
  );
}
