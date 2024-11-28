import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:testapp/constants/theme.dart';
import 'package:testapp/controllers/auth_controller.dart';
import 'package:testapp/firebase_options.dart';
import 'package:testapp/screens/auth/sign_in.dart';
import 'package:testapp/screens/home.dart';

import 'package:testapp/services/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Hive
  await Hive.initFlutter();
  // Open a box to store the token
  await Hive.openBox('userCredentialBox');
  runApp(const App());
  // await setup();
}

//Setup app
Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await settingUpFirebase();
  // Initialize Hive
  await Hive.initFlutter();
  // Open a box to store the token
  await Hive.openBox('userCredentialBox');
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

   
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyThemes.lightThem,
      darkTheme: MyThemes.darkTheme,
      home: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (controller) {
            //  print('Is loggedIn ${controller.userLogedIn}');
            return controller.userLogedIn.value ? Home() : SignIn();
          }),
    );
  }
}
