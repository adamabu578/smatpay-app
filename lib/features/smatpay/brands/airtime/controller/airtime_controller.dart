import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AirtimeController extends GetxController {
  var isLoading = false.obs;

  Future<void> buyAirtime({
    required String operator,
    required String phoneNumber,
    required String amount,
  }) async {
    try {
      isLoading(true);
      print("🔄 Initiating Airtime Purchase...");

      // Get token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        print("🚨 Authentication token missing!");
        Get.snackbar("Error", "User not authenticated");
        return;
      }

      const url = 'https://api.smatpay.live/airtime';
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
        Get.snackbar("Success", responseData['msg']);
      } else if (response.statusCode == 402) {
        Get.snackbar("Error", "Insufficient balance");
      } else if (response.statusCode == 401) {
        Get.snackbar("Error", "Transaction failed");
      } else {
        Get.snackbar("Error", responseData['msg'] ?? "An error occurred");
      }
    } catch (e) {
      print("❌ Error: $e");
      Get.snackbar("Error", "Something went wrong. Try again!");
    } finally {
      isLoading(false);
    }
  }
}