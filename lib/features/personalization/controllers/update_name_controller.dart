// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smatpay/data/repositories/user/user_repository.dart';
// import 'package:smatpay/features/personalization/controllers/user_controller.dart';
// import 'package:smatpay/features/smatpay/profile/screen/personalinformation.dart';
// import 'package:smatpay/utils/constants/image_strings.dart';
// //import 'packageay/utils/constants/image_strings.dart';
// import 'package:smatpay/utils/helpers/network_manager.dart';
// import 'package:smatpay/utils/popups/full_screen_loader.dart';
// import 'package:smatpay/utils/popups/loaders.dart';
//
// class TUpdateNameController extends GetxController {
//   static TUpdateNameController get instance => Get.find();
//
//   final firstName = TextEditingController();
//   final lastName = TextEditingController();
//   final phoneNo = TextEditingController(); // Controller for phone number input
//
//   final userController = TUserController.instance;
//   final userRepository = Get.put(TUserRepository());
//   GlobalKey<FormState> updatedUserNameFormKey = GlobalKey<FormState>();
//
//   /// init user data when Home Screen appears
//
//   @override
//   void onInit() {
//     initializeNames();
//     super.onInit();
//   }
//
//   /// Fetch user record
//   Future<void> initializeNames() async {
//     firstName.text = userController.user.value.firstName;
//     lastName.text = userController.user.value.lastName;
//     phoneNo.text = userController.user.value.phoneNumber;
//   }
//
//   Future<void> updateUserName() async {
//     try {
//       // Start Loading
//       TFullScreenLoader.openLoadingDialog(
//           'We are updating your information ...', TImages.docerAnimation);
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
//       if (!updatedUserNameFormKey.currentState!.validate()) {
//         // Remove loader
//         TFullScreenLoader.stopLoading();
//         return;
//       }
//
//       // Update user's first & Last name in the Firebase Firestore
//       Map<String, dynamic> name = {
//         'FirstName': firstName.text.trim(),
//         'LastName': lastName.text.trim(),
//         'PhoneNumber': phoneNo.text.trim(),
//       };
//       await userRepository.updateSingleField(name);
//
//       // update the Rx User value
//       userController.user.value.firstName = firstName.text.trim();
//       userController.user.value.lastName = lastName.text.trim();
//       userController.user.value.phoneNumber = phoneNo.text.trim();
//       // Remove loader
//       TFullScreenLoader.stopLoading();
//
//       // Show Success Message
//       TLoaders.successSnackBar(
//           title: 'Congratulations', message: 'Your Name has been updated');
//
//       // Move to previous screen
//       Get.off(() => const TPersonalInformationScreen());
//     } catch (e) {
//       // Remove loader
//       TFullScreenLoader.stopLoading();
//       // Show some Generic Error to the user
//       TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
//     }
//   }
// }
