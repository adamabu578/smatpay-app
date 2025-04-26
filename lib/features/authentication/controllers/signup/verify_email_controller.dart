// import 'dart:async';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:smatpay/common/widgets/success_screen/success_screen.dart';
// import 'package:smatpay/data/repositories/authentication/authentication_repository.dart';
// import 'package:smatpay/utils/constants/image_strings.dart';
// import 'package:smatpay/utils/constants/text_strings.dart';
// import 'package:smatpay/utils/popups/loaders.dart';
//
// class TVerifyEmailController extends GetxController {
//   static TVerifyEmailController get instance => Get.find();
//
//   /// Send Email whenever verify screen appears & set timer for auto redirect
//   ///
//   @override
//   void onInit() {
//     sendEmailVerification();
//     setTimerForAutoRedirect();
//     super.onInit();
//   }
//
//   /// Send Email Verification Link
//   sendEmailVerification() async {
//     try {
//       await TAuthenticationRepository.instance.sendEmailVerification();
//       TLoaders.successSnackBar(
//           title: 'Email sent',
//           message: 'Please Check your inbox and verify your email');
//     } catch (e) {
//       TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
//     }
//   }
//
//   ///
//   /// Timer to automatically redirect on Email Verification
//   setTimerForAutoRedirect() {
//     Timer.periodic(const Duration(seconds: 1), (timer) async {
//       await FirebaseAuth.instance.currentUser?.reload();
//       final user = FirebaseAuth.instance.currentUser;
//       if (user?.emailVerified ?? false) {
//         timer.cancel();
//         Get.off(() => TSuccessScreen(
//             image: TImages.successfullyRegisterAnimation,
//             title: TTexts.yourAccountCreatedTitle,
//             subTitle: TTexts.yourAccountCreatedSubTitle,
//             onPressed: () =>
//                 TAuthenticationRepository.instance.screenRedirect()));
//       }
//     });
//   }
//
//   ///
//   /// Manually check if email verified
//   checkEmailVerificationStatus() async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null && currentUser.emailVerified) {
//       Get.off(() => TSuccessScreen(
//           image: TImages.successfullyRegisterAnimation,
//           title: TTexts.yourAccountCreatedTitle,
//           subTitle: TTexts.yourAccountCreatedSubTitle,
//           onPressed: () =>
//               TAuthenticationRepository.instance.screenRedirect()));
//     }
//   }
// }
