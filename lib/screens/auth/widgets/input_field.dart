import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  const MyInput(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.icon,
      required this.validing,
      required this.label,
   
      });

  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  final RegExp validing;
  final String label;



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value != null 
        // && RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)
        ) {
          // print(value);
          return null;
        }
        //  print(value);
        // regExp.hasMatch('Hey value => ${value!}');
        return "Email est obligatoir, entrer un email valid svp!";
      },
      controller: controller,
   
      decoration: InputDecoration(
          prefixIcon: icon,
          contentPadding: const EdgeInsets.only(top: 9),
          border: InputBorder.none,
          hintText: hintText,
          labelText: label),
    );
  }
}
