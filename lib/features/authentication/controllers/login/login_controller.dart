import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smatpay/analytics/analytics_engine.dart';
import 'package:smatpay/data/repositories/authentication/authentication_repository.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/helpers/network_manager.dart';
import 'package:smatpay/utils/popups/full_screen_loader.dart';
import 'package:smatpay/utils/popups/loaders.dart';

class TLoginController extends GetxController {
  /// Variable
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
// final userController = Get.put(TUserController());
  String phoneNumber = '';

  @override
  void onInit() {
    super.onInit();
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
  }

  // @override
  // void onInit() {
  //   email.text = localStorage.read('REMEMBER_ME_EMAIL');
  //   password.text = localStorage.read('REMEMBER_ME_PASSWORD');
  //   super.onInit();
  // }

  ///Email and Password SignIN
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in ...', TImages.docerAnimation);

      // Check internet Connectivity
      final isConnected = await TNetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        // Remove loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // login user using Email & Password Authentication
      ////////  final userCredentials =
      await TAuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Log login event to Analytics
      TAnalyticsEngine.userLogsIn('EmailAndPassword');

      // Remove loader
      TFullScreenLoader.stopLoading();

      // Redirect
      TAuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Remove loader
      TFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // /// Google SignIn Authentication
  // Future<void> googleSignIn() async {
  //   try {
  //     // Start Loading
  //     TFullScreenLoader.openLoadingDialog(
  //         'Logging you in ...', TImages.docerAnimation);

  //     // Check internet Connectivity
  //     final isConnected = await TNetworkManager.instance.isConnected();
  //     if (!isConnected) {
  //       // Remove loader
  //       TFullScreenLoader.stopLoading();
  //       return;
  //     }

  //     // Google Authentication
  //     final userCredentials =
  //         await TAuthenticationRepository.instance.signInWithGoogle();

  //     // Save User Record
  //     await userController.saveUserRecord(userCredentials);

  //     // Remove loader
  //     TFullScreenLoader.stopLoading();

  //     // Redirect
  //     TAuthenticationRepository.instance.screenRedirect();
  //   } catch (e) {
  //     // Remove loader
  //     TFullScreenLoader.stopLoading();
  //     // Show some Generic Error to the user
  //     TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
  //   }
  // }
}
