import 'package:flutter/material.dart';
import 'package:testapp/constants/custom/my_input_theme.dart';

import 'package:testapp/constants/custom/text_theme.dart';

class MyThemes {
  MyThemes._();
  static ThemeData lightThem = ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
        toolbarTextStyle: TextStyle(color: Colors.white),
        color: Colors.red),
      brightness: Brightness.light,
      textTheme: MyText.forLightMode,
      primaryColor: Colors.red,
      inputDecorationTheme: MyInputTheme().lighInputTheme()
      );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
      color: Color.fromARGB(255, 109, 7, 0)),
    brightness: Brightness.dark,
    textTheme: MyText.forDrakMode,
    primaryColor: Colors.red,
     inputDecorationTheme: MyInputTheme().darkInputTheme()
  );
}
