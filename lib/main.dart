import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smatpay/analytics/analytics_engine.dart';
import 'package:smatpay/data/repositories/authentication/authentication_repository.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/authentication/controllers/profile/profile_controller.dart';
import 'features/authentication/controllers/signup/signup_controllerr.dart';
import 'firebase_options.dart';

/// ---- Entry point of Flutter App
Future<void> main() async {
  // widgets Binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => SignupController());
  Get.put(ProfileController());

  // Init Local Storage
  await GetStorage.init();

  //Todo: Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //Todo: Initialize Firebase

// Initialize Analytics Engine
  TAnalyticsEngine();
  //FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
    (FirebaseApp value) => Get.put(TAuthenticationRepository()),
  );

// ...

  //Todo: Initialize Authentication

  runApp(const App());
}
