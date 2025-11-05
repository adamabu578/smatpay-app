import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
    // Validate form
    if (!signupFormKey.currentState!.validate()) {
      return;
    }

    // Check privacy policy
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

    final url = Uri.parse('https://api.smatpay.live/signup');
    final requestBody = {
      "firstName": firstName.text.trim(),
      "lastName": lastName.text.trim(),
      "email": email.text.trim(),
      "phone": phoneNo.text.trim(),
      "password": password.text.trim(),
      "assignNuban": assignNuban.value,
    };

    // If user wants NUBAN, specify Payscribe provider (optional, defaults to payscribe)
    if (assignNuban.value) {
      requestBody.addAll({
        "nubanProvider": "payscribe",
      });
    }

    try {
      isLoading.value = true;
      Get.snackbar(
        'Processing',
        'Please wait...',
        snackPosition: SnackPosition.BOTTOM,
      );

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Account created successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to success screen first
        Get.offAll(() => SignupSuccessScreen(
          onContinue: () {
            // Then go to login after user presses continue
            Get.offAll(() => TLoginScreen());
          },
        ));
      } else {
        Get.snackbar(
          'Error',
          data['message'] ?? 'Signup failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Signup Error: $e");
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
