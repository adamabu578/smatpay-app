// features/authentication/controllers/forgot_password/forgot_password_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../utils/constants/api_constants.dart';
import '../../screens/password_configuration/reset_password_pending_screen.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  /// Send Reset Password Email
  Future<void> sendPasswordResetEmail() async {
    try {
      // Validate Form
      if (!forgotPasswordFormKey.currentState!.validate()) {
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
        Uri.parse(APIConstants.forgotPasswordEndpoint),
        body: {
          'email': email.text.trim(),
        },
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          data['msg'] ?? 'Password reset link sent to your email',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.to(() => const ResetPasswordPendingScreen());
      } else {
        Get.snackbar(
          'Error',
          data['msg'] ?? 'Failed to send reset link',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("Forgot Password Error: $e");
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
    email.dispose();
    super.onClose();
  }
}