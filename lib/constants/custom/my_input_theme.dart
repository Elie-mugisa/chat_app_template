// ignore_for_file: unused_element, non_constant_identifier_names

import 'package:flutter/material.dart';

class MyInputTheme {
  TextStyle _builtTextStyle(Color color, {double size = 14}) {
    return TextStyle(color: color, fontSize: size);
  }

  OutlineInputBorder _builtBorder(Color color, {double dbl_radius = 7}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(dbl_radius),
        borderSide: BorderSide(color: color, width: 1.0));
  }

   InputDecorationTheme lighInputTheme() =>
      InputDecorationTheme(
        contentPadding: const EdgeInsets.all(10), 
        // filled: true,
        // fillColor: Colors.blueGrey.shade100,
        // isDense: true, 
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        constraints: const BoxConstraints(maxHeight: double.infinity),
        enabledBorder: _builtBorder(Colors.grey),
        errorBorder: _builtBorder(Colors.red),
        border: _builtBorder(Colors.yellow),
        focusedBorder: _builtBorder(Colors.blue),
        disabledBorder: _builtBorder(Colors.grey.shade400),

        suffixStyle: _builtTextStyle(Colors.grey.shade700),
        counterStyle: _builtTextStyle(Colors.grey.shade800),
        focusedErrorBorder: _builtBorder(Colors.orange),
        floatingLabelStyle: _builtTextStyle(Colors.black),
        errorStyle: _builtTextStyle(Colors.red, size: 10.0),
        helperStyle: _builtTextStyle(Colors.black),
        hintStyle: _builtTextStyle(Colors.grey),
        labelStyle: _builtTextStyle(Colors.black),
        prefixStyle: _builtTextStyle(Colors.grey.shade800),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        alignLabelWithHint: true
        ); 

        InputDecorationTheme darkInputTheme() =>
      InputDecorationTheme(alignLabelWithHint: true,
        contentPadding: const EdgeInsets.all(10), 
        // filled: true,
        // fillColor: Colors.blueGrey.shade900,
        // isDense: true, 
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        constraints: const BoxConstraints(maxHeight: double.infinity),
        enabledBorder: _builtBorder(Colors.grey),
        errorBorder: _builtBorder(Colors.red),
        border: _builtBorder(Colors.yellow),
        focusedBorder: _builtBorder(Colors.blue),
        disabledBorder: _builtBorder(Colors.grey.shade400),

        suffixStyle: _builtTextStyle(Colors.grey.shade700),
        suffixIconColor: Colors.grey.shade700,
        prefixIconColor: Colors.grey.shade700,
        counterStyle: _builtTextStyle(Colors.grey.shade800),
        floatingLabelStyle: _builtTextStyle(Colors.grey),
        errorStyle: _builtTextStyle(Colors.red, size: 10.0),
        helperStyle: _builtTextStyle(Colors.black),
        hintStyle: _builtTextStyle(Colors.grey),
        labelStyle: _builtTextStyle(Colors.grey),focusedErrorBorder: _builtBorder(Colors.orange),
        prefixStyle: _builtTextStyle(Colors.grey.shade800)
        ); 
}
