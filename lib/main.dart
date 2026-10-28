import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_otp/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'config/flavors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await F().setBrandFromRemoteConfig();

  runApp(const App());
}
