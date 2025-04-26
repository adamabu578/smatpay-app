// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:smatpay/data/repositories/authentication/authentication_repository.dart';
// import 'package:smatpay/features/authentication/screens/password_configuration/reset_password.dart';
// import 'package:smatpay/utils/constants/image_strings.dart';
// import 'package:smatpay/utils/helpers/network_manager.dart';
// import 'package:smatpay/utils/popups/full_screen_loader.dart';
// import 'package:smatpay/utils/popups/loaders.dart';
//
// class TForgetPasswordController extends GetxController {
//   static TForgetPasswordController get instance => Get.find();
//
//   /// Variable
//   final email = TextEditingController();
//   GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
//
//   ///
//   sendPasswordResetEmail() async {
//     try {
//       // Start Loading
//       TFullScreenLoader.openLoadingDialog(
//           'Processing your request ...', TImages.docerAnimation);
//
//       // Check internet Connectivity
//       final isConnected = await TNetworkManager.instance.isConnected();
//       if (!isConnected) {
//         // Remove loader
//         TFullScreenLoader.stopLoading();
//         return;
//       }
//
//       // Form Validation
//       if (!forgetPasswordFormKey.currentState!.validate()) {
//         // Remove loader
//         TFullScreenLoader.stopLoading();
//         return;
//       }
//
//       // Send Email to Reset Password
//       await TAuthenticationRepository.instance
//           .sendPasswordResetEmail(email.text.trim());
//
//       // Remove loader
//       TFullScreenLoader.stopLoading();
//
//       // Show Success Screen
//       TLoaders.successSnackBar(
//           title: 'Email Sent',
//           message: 'Email Link Sent to Reset your Password'.tr);
//
//       // Redirect
//       Get.to(() => TResetPasswordScreen(email: email.text.trim()));
//     } catch (e) {
//       // Remove loader
//       TFullScreenLoader.stopLoading();
//       // Show some Generic Error to the user
//       TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
//     }
//   }
//
//   resendPasswordResetEmail(String email) async {
//     try {
//       // Start Loading
//       TFullScreenLoader.openLoadingDialog(
//           'Processing your request ...', TImages.docerAnimation);
//
//       // Check internet Connectivity
//       final isConnected = await TNetworkManager.instance.isConnected();
//       if (!isConnected) {
//         // Remove loader
//         TFullScreenLoader.stopLoading();
//         return;
//       }
//
//       // Send Email to Reset Password
//       await TAuthenticationRepository.instance.sendPasswordResetEmail(email);
//
//       // Remove loader
//       TFullScreenLoader.stopLoading();
//
//       // Show Success Screen
//       TLoaders.successSnackBar(
//           title: 'Email Sent',
//           message: 'Email Link Sent to Reset your Password'.tr);
//     } catch (e) {
//       // Remove loader
//       TFullScreenLoader.stopLoading();
//       // Show some Generic Error to the user
//       TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
//     }
//   }
// }
