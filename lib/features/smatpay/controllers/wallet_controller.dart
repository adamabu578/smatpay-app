import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WalletController extends GetxController {
  var balance = 0.0.obs;
  var isLoading = true.obs;
  var showBalance = true.obs; // Toggle for hiding/displaying balance

  @override
  void onInit() {
    super.onInit();
    fetchWalletBalance();
  }

  Future<void> fetchWalletBalance() async {
    try {
      isLoading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        print("🚨 No token found. User might be logged out.");
        isLoading.value = false;
        return;
      }

      print("📤 Fetching wallet balance with token: $token");

      final response = await http.get(
        Uri.parse('https://api.smatpay.live/balance'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("🌐 Wallet API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          balance.value = double.tryParse(data['data']['wallet'].toString()) ?? 0.0;
          print("💰 Balance updated: ₦${balance.value}");
        } else {
          print("❌ Failed to fetch balance: ${data['msg']}");
          Get.snackbar('Error', data['msg'] ?? 'Failed to fetch balance');
        }
      } else {
        print("❌ HTTP Error: ${response.statusCode}");
        Get.snackbar('Error', 'Failed to fetch balance');
      }
    } catch (e) {
      print("🚨 Error fetching wallet balance: $e");
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleBalanceVisibility() {
    showBalance.value = !showBalance.value;
  }
}
