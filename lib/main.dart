import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smatpay/analytics/analytics_engine.dart';
import 'package:smatpay/features/authentication/controllers/profile/profile_controller.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'features/authentication/controllers/forget_password/forget_password_controller.dart';

import 'features/smatpay/brands/transaction/transaction_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize controllers that need early initialization
  Get.put(TAuthenticationRepository());

  Get.put(ForgotPasswordController());
  Get.put(TransactionController());
  Get.put(ProfileController());


  // Start analytics
  TAnalyticsEngine();

  // Keep splash screen until auth check completes
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const App());

  // Remove splash screen after first frame
  WidgetsBinding.instance.addPostFrameCallback((_) {
    FlutterNativeSplash.remove();
  });
}