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
        Get.dialog(
          const Center(
            child: CircularProgressIndicator(),
          ),
          barrierDismissible: false,
        );

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

        // Close loading dialog
        Get.back();

        print("Virtual Account Response: ${nubanResponse.statusCode}");
        print("Virtual Account Body: ${nubanResponse.body}");

        if (nubanResponse.statusCode != 200) {
          Get.snackbar(
            'Error',
            'Failed to create virtual account. Please try again later.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
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
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );

      final signupUrl = Uri.parse(APIConstants.signupEndpoint);
      final requestBody = {
        "firstName": firstName.text.trim(),
        "lastName": lastName.text.trim(),
        "email": email.text.trim(),
        "phone": phoneNo.text.trim(),
        "password": password.text.trim(),
        "assignNuban": assignNuban.value,
        if (assignNuban.value) "nubanProvider": "payscribe",
        if (assignNuban.value) "virtualAccount": virtualAccountData,
      };

      print("Signup Request Body: $requestBody");

      final response = await http.post(
        signupUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      // Close loading dialog
      Get.back();

      print("Signup Response: ${response.statusCode}");
      print("Signup Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Account created successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAll(() => SignupSuccessScreen(
          onContinue: () => Get.offAll(() => TLoginScreen()),
        ));
      } else {
        Get.snackbar(
          'Error',
          data['message'] ?? 'Signup failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print("Signup Error Data: $data");
      }
    } catch (e) {
      // Close any open dialog before showing error
      if (Get.isDialogOpen ?? false) Get.back();

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
