import 'package:flutter/material.dart';
import 'package:note_app/core/ui/theme/const.dart';

final ThemeData darkTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: bottomNavigationBarColorDark),
    dialogBackgroundColor: dialogBackgroundColor,
    scaffoldBackgroundColor: backgroundScaffoldColorDark,
    iconTheme: const IconThemeData(color: Colors.white, size: 24),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: floatingButtonColor, foregroundColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: elevatedButton,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      errorStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
    ),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: appBarColor,
        surfaceTintColor: Colors.transparent),
    textTheme: const TextTheme(
      labelSmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
      labelMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      labelLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
    ),
    brightness: Brightness.dark,
    cardColor: noteColor);

final ThemeData lightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: bottomNavigationBarColorLight),
    dialogBackgroundColor: dialogBackgroundColorLight,
    scaffoldBackgroundColor: backgroundScaffoldColorLight,
    iconTheme: const IconThemeData(color: Colors.white, size: 24),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: floatingButtonColorLight,
        foregroundColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: elevatedButtonLight,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      errorStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
    ),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        foregroundColor: Colors.white,
        elevation: 0,
        backgroundColor: appBarColorLight,
        surfaceTintColor: Colors.transparent),
    textTheme: const TextTheme(
      labelSmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
      labelMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      labelLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
    ),
    brightness: Brightness.light,
    cardColor: noteColorLight);
