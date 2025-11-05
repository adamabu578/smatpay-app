// features/authentication/controllers/forgot_password/reset_password_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../screens/password_configuration/reset_password_success_screen.dart';


class ResetPasswordController extends GetxController {
  static ResetPasswordController get instance => Get.find();

  /// Variables
  final password = TextEditingController();
  final hidePassword = true.obs;
  final isLoading = false.obs;

  /// Reset Password
  Future<void> resetPassword(String token) async {
    try {
      // Validate Password
      if (password.text.isEmpty) {
        Get.snackbar(
          'Error',
          'Please enter your new password',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      isLoading.value = true;
      Get.snackbar(
        'Processing',
        'Please wait...',
        snackPosition: SnackPosition.BOTTOM,
      );

      // API Call
      final response = await http.post(
        Uri.parse('https://api.smatpay.live/reset-password'),
        body: {
          'password': password.text.trim(),
          'token': token,
        },
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          data['msg'] ?? 'Password reset successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAll(() => const PasswordResetSuccessScreen());
      } else {
        Get.snackbar(
          'Error',
          data['msg'] ?? 'Failed to reset password',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Reset Password Error: $e");
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
    password.dispose();
    super.onClose();
  }
}