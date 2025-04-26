import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:smatpay/data/repositories/authentication/authentication_repository.dart';
import 'package:smatpay/data/repositories/user/user_repository.dart';
import 'package:smatpay/features/authentication/screens/login/login.dart';
import 'package:smatpay/features/personalization/models/user_model.dart';
import 'package:smatpay/features/personalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:smatpay/utils/constants/colors.dart';
//import 'package:smatpay/features/personalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/helpers/network_manager.dart';
import 'package:smatpay/utils/popups/full_screen_loader.dart';
import 'package:smatpay/utils/popups/loaders.dart';

class TUserController extends GetxController {
  static TUserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<TUserModel> user = TUserModel
      .empty()
      .obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  // final userRepository = Get.put(TUserRepository());

  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // fetchUserRecord();
  }

  /// Fet user record
  // Future<void> fetchUserRecord() async {
  //   try {
  //     profileLoading.value = true;
  //     final user = await userRepository.fetchUserDetails();
  //     this.user(user);
  //   } catch (e) {
  //     user(TUserModel.empty());
  //   } finally {
  //     profileLoading.value = false;
  //   }
  // }

  /// Save user Record from any Registration provider
  // Future<void> saveUserRecord(UserCredential? userCredentials) async {
  //   try {
  //     // First Update Rx User and then check if user data is already stored. if not store new data
  //     await fetchUserRecord();
  //
  //     // if no Record  already stored.
  //     if (user.value.id.isEmpty) {
  //       if (userCredentials != null) {
  //         // Convert Name to First and Last Name
  //         final nameParts =
  //         TUserModel.nameParts(userCredentials.user!.displayName ?? '');
  //         final username = TUserModel.generateUsername(
  //             userCredentials.user!.displayName ?? '');
  //
  //         // Map Data
  //         final user = TUserModel(
  //           id: userCredentials.user!.uid,
  //           firstName: nameParts[0],
  //           lastName:
  //           nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
  //           username: username,
  //           email: userCredentials.user!.email ?? '',
  //           phoneNumber: userCredentials.user!.phoneNumber ?? '',
  //           profilePicture: userCredentials.user!.photoURL ?? '',
  //         );
  //
  //         /// Save user data
  //         await userRepository.saveUserRecord(user);
  //       }
  //     }
  //   } catch (e) {
  //     TLoaders.warningSnackBar(
  //         title: 'Data not saved',
  //         message:
  //         'Something went wrong while saving your information. You can re-save your data in your Profile.');
  //   }
  // }

/// Logout Account Warning
// void logoutAccountWarningPopup() {
//   Get.defaultDialog(
//       contentPadding: const EdgeInsets.all(TSizes.md),
//       title: 'Logout Account',
//       middleText: 'Are you sure you want to logout of your account?',
//       confirm: ElevatedButton(
//           onPressed: () => TAuthenticationRepository.instance.logout(),
//           style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               side: const BorderSide(color: Colors.red)),
//           child: const Padding(
//             padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
//             child: Text('Logout'),
//           )),
//       cancel: OutlinedButton(
//           onPressed: () => Navigator.of(Get.overlayContext!).pop(),
//           style: OutlinedButton.styleFrom(
//               // backgroundColor: Colors.red,
//               side: const BorderSide(color: TColors.white)),
//           child: const Text('Cancel')));
// }

/// Delete Account Warning
// void deleteAccountWarningPopup() {
//   Get.defaultDialog(
//       contentPadding: const EdgeInsets.all(TSizes.md),
//       title: 'Delete Account',
//       middleText:
//           'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
//       confirm: ElevatedButton(
//           onPressed: () async => deleteUserAccount(),
//           style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               side: const BorderSide(color: Colors.red)),
//           child: const Padding(
//             padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
//             child: Text('Delete'),
//           )),
//       cancel: OutlinedButton(
//           onPressed: () => Navigator.of(Get.overlayContext!).pop(),
//           child: const Text('Cancel')));
// }

/// Delete User Account
// void deleteUserAccount() async {
//   try {
//     // Start Loading
//     TFullScreenLoader.openLoadingDialog(
//         'Processing ...', TImages.docerAnimation);
//
//     // First re-authenticate user
//     final auth = TAuthenticationRepository.instance;
//     final provider =
//         auth.authUser!.providerData.map((e) => e.providerId).first;
//     if (provider.isNotEmpty) {
//       // Re Verify Auth Email
//       // if (provider == 'google.com') {
//       //   await auth.signInWithGoogle();
//       //   await auth.deleteAccount();
//       //   TFullScreenLoader.stopLoading();
//       //   Get.offAll(() => const TLoginScreen());
//       // } else
//       if (provider == 'password') {
//         TFullScreenLoader.stopLoading();
//         Get.to(() => const TReAuthLoginForm());
//       }
//     }
//   } catch (e) {
//     // Remove loader
//     TFullScreenLoader.stopLoading();
//     // Show some Generic Error to the user
//     TLoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
//   }
// }

/// Re- Authenticate before deleting
//   Future<void> reAuthenticateEmailAndPasswordUser() async {
//     try {
//       // Start Loading
//       TFullScreenLoader.openLoadingDialog(
//           'Processing ...', TImages.docerAnimation);
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
//       if (!reAuthFormKey.currentState!.validate()) {
//         // Remove loader
//         TFullScreenLoader.stopLoading();
//         return;
//       }
//
//   //     await TAuthenticationRepository.instance
//   //         .reAuthenticateWithEmailAndPassword(
//   //             verifyEmail.text.trim(), verifyPassword.text.trim());
//   //     await TAuthenticationRepository.instance.deleteAccount();
//   //     TFullScreenLoader.stopLoading();
//   //     Get.offAll(() => const TLoginScreen());
//   //   } catch (e) {
//   //     // Remove loader
//   //     TFullScreenLoader.stopLoading();
//   //     // Show some Generic Error to the user
//   //     TLoaders.warningSnackBar(title: 'Oh Snap', message: e.toString());
//   //   }
//   // }
//
//   /// Upload Profile Images
//   uploadUserProfilePicture() async {
//     try {
//       final image = await ImagePicker().pickImage(
//           source: ImageSource.gallery,
//           imageQuality: 70,
//           maxHeight: 512,
//           maxWidth: 512);
//       if (image != null) {
//         imageUploading.value = true;
//         // Upload image
//         final imageUrl =
//             await userRepository.uploadImage('Users/images/Profile/', image);
//
//         // Update User Image Record
//         Map<String, dynamic> json = {'ProfilePicture': imageUrl};
//         await userRepository.updateSingleField(json);
//
//         user.value.profilePicture = imageUrl;
//         user.refresh();
//
//         TLoaders.successSnackBar(
//             title: 'Congratulations',
//             message: 'Your Profile Image has been updated!');
//       }
//     } catch (e) {
//       // Remove loader
//       TFullScreenLoader.stopLoading();
//       // Show some Generic Error to the user
//       TLoaders.errorSnackBar(
//           title: 'Oh Snap', message: 'Something went wrong: $e');
//     } finally {
//       imageUploading.value = false;
//     }
//   }
// }
}