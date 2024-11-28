import 'package:firebase_core/firebase_core.dart';

import 'package:testapp/firebase_options.dart';

Future<void> settingUpFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

