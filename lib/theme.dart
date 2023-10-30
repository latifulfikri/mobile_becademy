import 'package:flutter/material.dart';

class ThemeClass {
  final Color lightTextAppBarColor = Color.fromRGBO(62, 75, 124, 1);
  final Color lightBackgroundColor = Color.fromRGBO(246, 246, 250, 1);
  final Color lightPrimaryColor = Color.fromRGBO(62, 75, 124, 1);
  final Color lightSecondaryColor = Color.fromRGBO(32, 32, 32, 1);
  final Color lightTertiaryColor = Color.fromRGBO(174, 174, 174, 1);
  final Color lightTertiaryContainerColor = Color.fromRGBO(255, 255, 255, 1);
  
  final Color darkTextAppBarColor = Color.fromRGBO(255, 255, 255, 1);
  final Color darkBackgroundColor = Color.fromRGBO(0, 0, 0, 1);
  final Color darkTertiaryContainerColor = Color.fromRGBO(32, 32, 32, 1);
  final Color darkPrimaryColor = Color.fromRGBO(62, 75, 124, 1);
  // final Color darkPrimaryColor = Color.fromRGBO(10, 20, 45, 1);
  final Color darkSecondaryColor = Color.fromRGBO(246, 246, 250, 1);
  final Color darkTertiaryColor = Color.fromRGBO(132, 132, 132, 1);

  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromRGBO(246, 246, 250, 0.7),
      titleTextStyle: TextStyle(
        color: _themeClass.lightTextAppBarColor,
        fontWeight: FontWeight.bold,
        fontSize: 18
      )
    ),
    scaffoldBackgroundColor: _themeClass.lightBackgroundColor,
    primaryColor: _themeClass.lightPrimaryColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: _themeClass.lightPrimaryColor,
      secondary: _themeClass.lightSecondaryColor,
      tertiary: _themeClass.lightTertiaryColor,
      tertiaryContainer: _themeClass.lightTertiaryContainerColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        foregroundColor: Colors.white,
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      iconColor:_themeClass.lightTextAppBarColor,
      suffixIconColor: _themeClass.lightTextAppBarColor,
      prefixIconColor: _themeClass.lightTextAppBarColor
    ),
  );
  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
      titleTextStyle: TextStyle(
        color: _themeClass.darkTextAppBarColor,
        fontWeight: FontWeight.bold,
        fontSize: 18
      )
    ),
    scaffoldBackgroundColor: _themeClass.darkBackgroundColor,
    primaryColor: _themeClass.darkPrimaryColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: _themeClass.darkPrimaryColor,
      secondary: _themeClass.darkSecondaryColor,
      tertiary: _themeClass.darkTertiaryColor,
      tertiaryContainer: _themeClass.darkTertiaryContainerColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        foregroundColor: Colors.white,
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      iconColor:_themeClass.darkTextAppBarColor,
      suffixIconColor: _themeClass.darkTextAppBarColor,
      prefixIconColor: _themeClass.darkTextAppBarColor
    ),
  );
}

ThemeClass _themeClass = ThemeClass();