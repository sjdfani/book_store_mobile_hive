import 'package:flutter/material.dart';

final ThemeData customBlueTheme = ThemeData.light().copyWith(
  // Primary color for the application
  primaryColor: Color.fromARGB(255, 31, 148, 177),

  // Accent color for buttons, selected text, etc.
  hintColor: Colors.lightBlueAccent,

  // Background color of the app
  scaffoldBackgroundColor: Colors.white,

  // App bar theme
  appBarTheme: AppBarTheme(
    color: Colors.blue,
    toolbarTextStyle: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ).bodyMedium,
    titleTextStyle: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ).titleLarge,
  ),

  // Button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      alignment: Alignment.center,
      minimumSize: const Size(100, 45),
    ),
  ),
);

final ThemeData customDarkTheme = ThemeData.dark().copyWith(
  // Primary color for the application
  primaryColor: Colors.blue[700],

  // Accent color for buttons, selected text, etc.
  hintColor: Colors.cyanAccent,

  // Background color of the app
  scaffoldBackgroundColor: Colors.grey[900],

  // App bar theme
  appBarTheme: AppBarTheme(
    color: Colors.purple,
    toolbarTextStyle: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ).bodyMedium,
    titleTextStyle: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ).titleLarge,
  ),

  // Button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.purple.shade300,
      alignment: Alignment.center,
      minimumSize: const Size(100, 45),
    ),
  ),
);

final ThemeData customLightTheme = ThemeData.light().copyWith(
  // Primary color for the application
  primaryColor: Colors.teal,

  // Accent color for buttons, selected text, etc.
  hintColor: Colors.tealAccent,

  // Background color of the app
  scaffoldBackgroundColor: Colors.white,

  // App bar theme
  appBarTheme: AppBarTheme(
    color: Colors.teal,
    toolbarTextStyle: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ).bodyMedium,
    titleTextStyle: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ).titleLarge,
  ),

  // Button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.teal,
      alignment: Alignment.center,
      minimumSize: const Size(100, 45),
    ),
  ),
);
