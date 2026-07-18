import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/constants/api_constants.dart';
import '../../screens/login/login.dart';
import '../../screens/signup/signup_success_screen.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Form Controllers
  final signupFormKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNo = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;

  // NUBAN toggle
  final assignNuban = false.obs;
  final privacyPolicy = false.obs;

  // Loading State
  final isLoading = false.obs;

  // Safely close any open dialog without triggering GetX snackbar internals
  // The original implementation sometimes failed to dismiss the loading
  // indicator before navigating, leaving a spinner overlay on top of the
  // success screen ("it only loads").
  void _safeCloseDialog() {
    try {
      // keep popping until there is no dialog left; Get.isDialogOpen can be
      // unreliable when the route stack is changing.
      while (Get.isDialogOpen ?? false) {
        if (Get.overlayContext != null) {
          Navigator.of(Get.overlayContext!).pop();
        } else if (Get.context != null) {
          Navigator.of(Get.context!).pop();
        } else {
          // fallback will pop the last route (dialog or page)
          Get.back();
        }
      }
    } catch (e) {
      print('safeCloseDialog error: $e');
    }
  }

  /// Show Success Popup
  void _showSuccessPopup() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 110,
              ),
              const SizedBox(height: 24),
              Text(
                'Account Created Successfully!',
                textAlign: TextAlign.center,
                style: Theme.of(Get.context!).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Your account has been successfully created. You can now login.',
                textAlign: TextAlign.center,
                style: Theme.of(Get.context!).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close the dialog
                    Get.offAll(() => TLoginScreen());
                  },
                  child: const Text('Continue to Login'),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// Signup Function
  Future<void> signup() async {
    if (!signupFormKey.currentState!.validate()) return;

    if (!privacyPolicy.value) {
      Get.snackbar(
        'Error',
        'You must accept the Terms & Conditions to proceed.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      Map<String, dynamic> virtualAccountData = {};

      // 🔹 Step 1: Create Virtual Account (if user checked the box)
      if (assignNuban.value) {
        // `isLoading` is already true so the UI shows a spinner on the button.
        // having an extra dialog caused problems where it wasn't dismissed
        // before navigation, so we're dropping it entirely.
        print("Creating virtual account with Payscribe...");

        final nubanUrl = Uri.parse(APIConstants.virtualAccountEndpoint);
        final nubanBody = jsonEncode({
          "nuban_provider": "payscribe",
        });

        final nubanResponse = await http.post(
          nubanUrl,
          headers: {"Content-Type": "application/json"},
          body: nubanBody,
        );

        // (no dialog to close)

        print("Virtual Account Response: ${nubanResponse.statusCode}");
        print("Virtual Account Body: ${nubanResponse.body}");

        if (nubanResponse.statusCode != 200) {
          // handle unauthorized separately
          if (nubanResponse.statusCode == 401) {
            Get.snackbar(
              'Error',
              'Access denied when creating virtual account. Please check your API credentials.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else {
            // if API returned a message, show it, otherwise generic
            final body = nubanResponse.body;
            String msg = 'Failed to create virtual account. Please try again later.';
            try {
              final json = jsonDecode(body);
              if (json is Map && json['msg'] != null) {
                msg = json['msg'];
              }
            } catch (_) {}

            Get.snackbar(
              'Error',
              msg,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }

          isLoading.value = false;
          return; // Stop signup process
        }

        final nubanData = jsonDecode(nubanResponse.body);

        if (nubanData['status'] != 'success') {
          Get.snackbar(
            'Error',
            nubanData['msg'] ?? 'Virtual account creation failed.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          print("Virtual Account Error: $nubanData");
          isLoading.value = false;
          return; // Stop signup process
        }

        // ✅ Save returned virtual account data
        virtualAccountData = nubanData['data'] ?? {};

        print("Virtual account created successfully: $virtualAccountData");
      }

      // 🔹 Step 2: Proceed with Signup
      // we already show loading via `isLoading` in the form so the extra
      // Get.dialog is unnecessary and was causing navigation to be obscured.

      final signupUrl = Uri.parse(APIConstants.signupEndpoint);
      final requestBody = {
        "firstName": firstName.text.trim(),
        "lastName": lastName.text.trim(),
        "email": email.text.trim(),
        "phone": phoneNo.text.trim(),
        "password": password.text.trim(),
        if (assignNuban.value)
          "assignNuban": "yes", // ✅ string "yes" not boolean
        if (assignNuban.value) "nubanProvider": "payscribe",
        if (assignNuban.value) "virtualAccount": virtualAccountData,
      };

      print("Signup Request Body: $requestBody");

      final response = await http.post(
        signupUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      // nothing to close; the form spinner will disappear when isLoading is
      // set to false below

      print("Signup Response: ${response.statusCode}");
      print("Signup Body: ${response.body}");

      final data = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          data['status'] == 'success') {
        // close any remaining loading dialog _before_ routing. if a dialog
        // stays open the user will just see the spinner and think the app is
        // still loading.
        _safeCloseDialog();

        // reset loading flag before navigating; the controller may be disposed
        // by Get.offAll and we don't want a stale observer stuck in 'true'.
        isLoading.value = false;

        // ✅ Show success popup instead of navigating to success page
        _showSuccessPopup();
        return; // exit early so finally block doesn't set loading again
      } else {
        Get.snackbar(
          'Error',
          data['msg'] ?? 'Signup failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print("Signup Error Data: $data");
      }
    } catch (e) {
      // close any dialog that might still be open
      _safeCloseDialog();
      print("Signup Exception: $e");
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phoneNo.dispose();
    password.dispose();
    super.onClose();
  }
}
