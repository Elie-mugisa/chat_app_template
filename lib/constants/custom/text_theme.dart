import 'package:flutter/material.dart';

class MyText {
  MyText._();
  static TextTheme forLightMode =
      TextTheme(titleLarge: const TextStyle().copyWith(color: Colors.black));
  static TextTheme forDrakMode =
      TextTheme(titleLarge: const TextStyle().copyWith(color: Colors.white));
}
