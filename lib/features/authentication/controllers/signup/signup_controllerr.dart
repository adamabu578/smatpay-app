import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../screens/login/login.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final signupFormKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNo = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final bvn = TextEditingController();
  final accountNumber = TextEditingController();
  final bankCode = TextEditingController();
  final assignNuban = false.obs;

  final privacyPolicy = false.obs;
  final isLoading = false.obs;
  /// Signup Function
  Future<void> signup() async {
    if (!signupFormKey.currentState!.validate()) {
      return;
    }

    if (!privacyPolicy.value) {
      Get.snackbar('Error', 'You must accept the Terms & Conditions to proceed.',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final url = Uri.parse('https://api.smatpay.live/signup');

    // Create a Map first, not a JSON string
    final requestBody = {
      "firstName": firstName.text.trim(),
      "lastName": lastName.text.trim(),
      "email": email.text.trim(),
      "phone": phoneNo.text.trim(),
      "password": password.text.trim(),
      "assignNuban": assignNuban.value ? "yes" : "no", // Add this line
    };

    // Add BVN-related fields if assigning NUBAN
    if (assignNuban.value) {
      requestBody.addAll({
        "bvn": bvn.text.trim(),
        "accountNumber": accountNumber.text.trim(),
        "bankCode": bankCode.text.trim(),
      });
    }

    try {
      isLoading.value = true;
      Get.snackbar('Processing', 'Please wait...', snackPosition: SnackPosition.BOTTOM);
      print("Signing up user...");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody), // Encode to JSON here
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Account created successfully!',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAll(() => TLoginScreen());
      } else {
        Get.snackbar('Error', data['message'] ?? 'Signup failed',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print("Signup Error: $e");
      Get.snackbar('Error', 'Something went wrong. Please try again.',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}