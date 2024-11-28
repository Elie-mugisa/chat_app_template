// ignore_for_file: avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final isObscure = true.obs;

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  void viewInput() {
    isObscure.value = !isObscure.value;
    update();
  }
}
