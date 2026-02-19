import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../../utils/constants/api_constants.dart';

class AirtimeController extends GetxController {
  var isLoading = false.obs;

  /// Transaction tracking
  final transactionStatus = ''.obs;
  final transactionId = RxnString();
  final transactionMessage = ''.obs;

  Future<void> buyAirtime({
    required String operator,
    required String phoneNumber,
    required String amount,
  }) async {
    try {
      isLoading(true);
      transactionStatus.value = 'pending';
      print("🔄 Initiating Airtime Purchase...");

      // Get token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        print("🚨 Authentication token missing!");
        transactionStatus.value = 'failed';
        Get.snackbar("Error", "User not authenticated");
        return;
      }

      const url = APIConstants.airtimeEndpoint;
      final body = jsonEncode({
        "operator": operator,
        "phoneNumber": phoneNumber,
        "amount": int.tryParse(amount) ?? 0,
      });

      print("📤 Sending request to: $url");
      print("📦 Payload: $body");

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      final responseData = jsonDecode(response.body);
      print("🌐 API Response: ${response.body}");

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        // ✅ Set transaction details
        transactionId.value = responseData['transactionId']?.toString() ??
            responseData['transaction_id']?.toString() ??
            responseData['reference']?.toString() ??
            DateTime.now().millisecondsSinceEpoch.toString();

        transactionMessage.value = responseData['msg'] ?? 'Airtime purchase successful!';
        transactionStatus.value = 'success';

        // Don't show snackbar, let the UI navigate to success screen

      } else if (response.statusCode == 402) {
        transactionStatus.value = 'failed';
        Get.snackbar("Error", "Insufficient balance");

      } else if (response.statusCode == 401) {
        transactionStatus.value = 'failed';
        Get.snackbar("Error", "Transaction failed");

      } else {
        transactionStatus.value = 'failed';
        Get.snackbar("Error", responseData['msg'] ?? "An error occurred");
      }
    } catch (e) {
      print("❌ Error: $e");
      transactionStatus.value = 'failed';
      Get.snackbar("Error", "Something went wrong. Try again!");
    } finally {
      isLoading(false);
    }
  }

  /// Reset transaction state
  void reset() {
    transactionStatus.value = '';
    transactionId.value = null;
    transactionMessage.value = '';
  }
}