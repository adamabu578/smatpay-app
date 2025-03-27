import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../navigation_menu.dart';

class TLoginController extends GetxController {
  static TLoginController get instance => Get.find();

  final loginFormKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final isLoading = false.obs; // Loader state

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials(); // Load saved email & password if "Remember Me" was checked
  }

  /// API Login Function
  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) {
      print("⚠️ Form validation failed.");
      return;
    }

    isLoading.value = true;
    print("⏳ Logging in...");

    final url = Uri.parse('https://api.smatpay.live/login');
    final body = jsonEncode({
      "email": email.text.trim(),
      "password": password.text.trim(),
    });

    try {
      print("📤 Sending request to API: $url");
      print("🔑 Request Body: $body");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      final data = jsonDecode(response.body);
      print("✅ Response Received: ${response.body}");

      if (response.statusCode == 200 && data['status'] == 'success') {
        print("🎉 Login successful!");
        String token = data['token'];

        await _saveToken(token);
        print("🔐 Token saved: $token");

        if (rememberMe.value) {
          await _saveCredentials();
          print("💾 Credentials saved (Remember Me checked)");
        } else {
          await _clearCredentials();
          print("🗑️ Credentials cleared (Remember Me unchecked)");
        }

        Get.snackbar('Success', 'Logged in successfully!',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);

        Get.offAll(() => const TNavigationMenu()); // Navigate to main menu
      } else {
        print("❌ Login failed: ${data['msg']}");
        Get.snackbar('Error', data['msg'] ?? 'Login failed',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print("🚨 Error during login: $e");
      Get.snackbar('Error', 'Something went wrong. Please try again.',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
      print("🔄 Login process completed.");
    }
  }

  /// Save token to SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  /// Retrieve token from SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  /// **Logout Confirmation Popup**
  void logoutAccountWarningPopup() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to log out?",
      textConfirm: "Yes, Logout",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back(); // Close the dialog
        Future.delayed(Duration(milliseconds: 300), () {
          logout(); // Wait briefly, then logout
        });
      },
    );
  }


  /// **Logout function**
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    print("🚪 Logged out. Token removed.");

    // Navigate to login screen
    Get.offAllNamed('/login');
  }

  /// Save email & password when "Remember Me" is checked
  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_email', email.text.trim());
    await prefs.setString('saved_password', password.text.trim());
    await prefs.setBool('remember_me', true);
  }

  /// Load saved email & password if "Remember Me" was previously checked
  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('remember_me') ?? false) {
      email.text = prefs.getString('saved_email') ?? '';
      password.text = prefs.getString('saved_password') ?? '';
      rememberMe.value = true;
      print("🔄 Loaded saved credentials.");
    } else {
      print("📭 No saved credentials found.");
    }
  }

  /// Clear saved email & password when "Remember Me" is unchecked
  Future<void> _clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_email');
    await prefs.remove('saved_password');
    await prefs.setBool('remember_me', false);
  }
}
