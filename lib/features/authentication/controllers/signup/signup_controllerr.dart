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
  final bvn = TextEditingController();
  final accountNumber = TextEditingController();
  final bankCode = TextEditingController();
  final assignNuban = false.obs;
  final privacyPolicy = false.obs;

  // Loading States
  final isLoading = false.obs;
  final isLoadingBanks = false.obs;

  // Bank Selection
  final selectedBank = RxString('');
  final banks = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBanks();
  }

  /// Fetches list of banks from API
  Future<void> fetchBanks() async {
    try {
      isLoadingBanks.value = true;
      final response = await http.get(
        Uri.parse('https://api.smatpay.live/banks'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          banks.value = List<Map<String, dynamic>>.from(data['data']);
        } else {
          throw Exception(data['msg'] ?? 'Failed to load banks');
        }
      } else {
        throw Exception('Failed to load banks: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching banks: $e");
      Get.snackbar(
        'Error',
        'Failed to load bank list. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingBanks.value = false;
    }
  }

  /// Gets bank code by bank name
  String? getBankCodeByName(String bankName) {
    try {
      final bank = banks.firstWhere(
            (bank) => bank['name'] == bankName,
        orElse: () => {},
      );
      return bank['code']?.toString();
    } catch (e) {
      print("Error getting bank code: $e");
      return null;
    }
  }

  /// Handles bank selection change
  void onBankSelected(String? bankName) {
    if (bankName != null) {
      selectedBank.value = bankName;
      final code = getBankCodeByName(bankName);
      if (code != null) {
        bankCode.text = code;
      } else {
        bankCode.clear();
        Get.snackbar(
          'Error',
          'Could not determine bank code for selected bank',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

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

    // Validate bank selection if NUBAN is enabled
    if (assignNuban.value && (selectedBank.value.isEmpty || bankCode.text.isEmpty)) {
      Get.snackbar(
        'Error',
        'Please select your bank',
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
      "assignNuban": assignNuban.value ? "yes" : "no",
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

      // In your SignupController's signup method:
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
      }
       else {
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
    bvn.dispose();
    accountNumber.dispose();
    bankCode.dispose();
    super.onClose();
  }
}