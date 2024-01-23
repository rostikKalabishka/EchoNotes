import 'package:flutter/material.dart';
import 'package:note_app/ui/theme/const.dart';

ThemeData darkTheme = ThemeData(
    dialogBackgroundColor: dialogBackgroundColor,
    scaffoldBackgroundColor: backgroundScaffoldColorDark,
    iconTheme: const IconThemeData(color: Colors.white, size: 24),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: floatingButtonColor, foregroundColor: Colors.white),
    //indicatorColor: ,
    appBarTheme: const AppBarTheme(
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

// ThemeData lightTheme =
//     ThemeData(backgroundColor: Colors.white, brightness: Brightness.light);
