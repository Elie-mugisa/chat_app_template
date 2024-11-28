// ignore_for_file: unused_field, avoid_print, must_call_super, body_might_complete_normally_nullable, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testapp/screens/auth/sign_in.dart';
import 'package:testapp/screens/home.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final userLogedIn = false.obs;

  final ImagePicker _picker = ImagePicker();
  File? selectedImg;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User? _user;
  User? get getUser => _user;

  List userList = [].obs;

  @override
  void onInit() {
    loadCredential();
    gettingUsers();
  }

  //Getting users
  Future<void> gettingUsers() async {
    try {
      //fetching from users collection
      QuerySnapshot snapshot =
          await _firebaseFirestore.collection('users').get();

      //Extractiong documents from the collection
      userList = snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
      // print(userList[0]['name']);
      update();

      // 
    } catch (e) {
      print(e);
    }
  }

  /// login user
  Future<bool> login(String email, String password) async {
    try {
      isLoading.value = true;
      update();

      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        _user = credential.user;
        // print('H E Y Y Y Y Y   W E    J U S T    L O G I N');
        Get.rawSnackbar(
            messageText: const Text(
              'Connecter avec succee!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green);
        // print(_user);
        saveCredential(true);
        return true;
      }
      isLoading.value = false;
      update();
    } catch (e) {
      saveCredential(false);
      print(e);
    } finally {
      isLoading.value = false;
      update();
    }
    print('Hoooooooo   L O G I N  Failllled');
    Get.rawSnackbar(
        messageText: const Text(
          'Connexion echouee',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red);
    saveCredential(false);
    // Get.
    return false;
  }

  Future<void> register(
      {required String email,
      required String password,
      required String name,
      required String imagePath}) async {
    try {
      isLoading.value = true;
      update();

      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firebaseFirestore
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'uid': credential.user!.uid,
        'name': name,
        'email': email,
        'imagePath': imagePath
      });

      if (credential.user != null) {
        _user = credential.user;

        // print('H E Y Y Y Y Y   Created joyfully');
        Get.rawSnackbar(
            messageText: const Text(
              'Inscrit avec succee!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green);
        print(_user);
        saveCredential(true);
        Get.offAll(() => Home());
      }
      isLoading.value = false;
      update();
    } catch (e) {
      saveCredential(true);
      print(e);
    } finally {
      isLoading.value = false;
      update();
    }
    // print('Hoooooooo   Ipossible de vous inscrire');
    // Get.rawSnackbar(
    //     messageText: const Text(
    //       'Connexion echouee',
    //       style: TextStyle(color: Colors.white),
    //     ),
    //     backgroundColor: Colors.red);
    // saveCredential(false);
  }

  /// Logout user
  Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();
      logInOut();
      Get.rawSnackbar(
          messageText: const Text(
            'Deconnecter avec succee!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  //Getting users

  ///Picking image
  Future<void> getImageFromGallery() async {
    final XFile? _file = await _picker.pickImage(source: ImageSource.gallery);
    if (_file != null) {
      selectedImg = File(_file.path);
      update();

      print(selectedImg);
    }
  }

  // Load credential from Hive
  void loadCredential() async {
    var box = await Hive.openBox('userCredentialBox');
    var savedCredential = box.get('islogged', defaultValue: false);
    userLogedIn.value = savedCredential;
    update();
  }

  // Save credential to Hive
  void saveCredential(bool islogged) async {
    var box = await Hive.openBox('userCredentialBox');
    await box.put('islogged', islogged);
    userLogedIn.value = islogged;
    update();
  }

  // Clear credentail from Hive
  void logInOut() async {
    var box = await Hive.openBox('userCredentialBox');
    await box.delete('islogged');
    userLogedIn.value = false;
    update();
    Get.offAll(() => SignIn());
  }
}




/*

StreamBuilder(
      //   stream: _firebaseFirestore.collection('users').snapshots(),
      //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     // if (snapshot.connectionState == ConnectionState.waiting) {
      //     //   return Center(child: CircularProgressIndicator());
      //     // }

      //     // if (snapshot.hasError) {
      //     //   return Center(child: Text('Something went wrong!'));
      //     // }

      //     // Extract data from the snapshot and display it
      //     var usersList = snapshot.data?.docs.map((doc) {
      //       return doc.data() as Map<String, dynamic>;
      //     }).toList();

      //     return ListView.builder(
      //       itemCount: usersList?.length ?? 0,
      //       itemBuilder: (context, index) {
      //         var user = usersList![index];
      //         return ListTile(
      //           title: Text(user['name'] ?? 'No Name'),
      //           subtitle: Text(user['email'] ?? 'No Email'),
      //         );
      //       },
      //     );
      //   },
      // );
*/