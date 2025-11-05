import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../brands/electricity/success_page.dart';

class ElectricityController extends GetxController {
  final RxString selectedProvider = 'ikedc'.obs;
  final RxString meterType = 'prepaid'.obs;
  final RxString meterNumber = ''.obs;
  final RxString customerName = ''.obs;
  final RxString customerAddress = ''.obs;
  final RxString accountType = ''.obs;
  final RxBool canVend = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isVerifying = false.obs;
  final RxBool isPurchasing = false.obs;
  final RxInt selectedAmount = 0.obs;
  final RxString phoneNumber = ''.obs;

  final List<int> prepaidAmounts = [1000, 2000, 3000, 5000, 10000, 20000];
  final List<int> postpaidAmounts = [2000, 5000, 10000, 20000, 50000];

  Future<void> verifyRecipient() async {
    try {
      isVerifying.value = true;
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      // Validate token exists
      if (token.isEmpty) {
        throw 'Authentication required. Please login again.';
      }

      // Validate meter number
      if (meterNumber.value.isEmpty) {
        throw 'Please enter a valid meter number';
      }

      final response = await http.post(
        Uri.parse('https://api.smatpay.live/electricity/recipient/verify'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'provider': selectedProvider.value,
          'recipient': meterNumber.value.trim(), // added trim()
          'type': meterType.value,
        }),
      );

      print('Verify Recipient Status Code: ${response.statusCode}');
      print('Verify Recipient Response: ${response.body}');

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 401) {
        // Clear invalid token and prompt re-login
        await prefs.remove('auth_token');
        throw 'Session expired. Please login again.';
      }

      if (response.statusCode == 200) {
        if (responseBody['status'] == 'success') {
          customerName.value = responseBody['data']['customerName'] ?? '';
          customerAddress.value = responseBody['data']['address'] ?? '';
          accountType.value = responseBody['data']['accountType'] ?? '';
          canVend.value = responseBody['data']['canVend'] == 'yes';
          Get.snackbar('Success', 'Customer verified successfully',
              backgroundColor: Colors.green, colorText: Colors.white);
        } else {
          throw responseBody['msg'] ?? 'Cannot verify customer';
        }
      } else {
        throw responseBody['msg'] ??
            'Failed to verify customer (${response.statusCode})';
      }
    } catch (e) {
      print('Error verifying recipient: $e');
      String errorMessage = e.toString();

      // Handle specific error cases
      if (e.toString().contains('401')) {
        errorMessage = 'Session expired. Please login again.';
      } else if (e.toString().contains('SocketException')) {
        errorMessage = 'No internet connection';
      }

      Get.snackbar('Error', errorMessage,
          backgroundColor: Colors.red, colorText: Colors.white);
      resetCustomerDetails();
    } finally {
      isVerifying.value = false;
    }
  }

  Future<void> purchaseElectricity() async {
    try {
      isPurchasing.value = true;
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';
      final userPhone = prefs.getString('phone') ?? '';

      final response = await http.post(
        Uri.parse('https://api.smatpay.live/electricity/electricity/purchase'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'provider': selectedProvider.value,
          'recipient': meterNumber.value,
          'type': meterType.value,
          'amount': selectedAmount.value,
          'phone': phoneNumber.value.isNotEmpty ? phoneNumber.value : userPhone,
        }),
      );

      print('Purchase Status Code: ${response.statusCode}');
      print('Purchase Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          Get.offAll(() => SuccessPage(
            message:
            'Electricity purchase successful! Amount: NGN ₦${selectedAmount.value}',
            transactionDetails: data['data'],
          ));
        } else {
          throw data['msg'] ?? 'Purchase failed';
        }
      } else {
        throw 'Failed to purchase electricity: ${response.reasonPhrase}';
      }
    } catch (e) {
      print('Error purchasing electricity: $e');
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isPurchasing.value = false;
    }
  }

  void resetCustomerDetails() {
    customerName.value = '';
    customerAddress.value = '';
    accountType.value = '';
    canVend.value = false;
  }

  void selectAmount(int amount) {
    selectedAmount.value = amount;
  }
}