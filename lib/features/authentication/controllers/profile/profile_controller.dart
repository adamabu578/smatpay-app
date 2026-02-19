import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/constants/api_constants.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  // --- Profile Data ---
  var fullName = ''.obs;
  var email = ''.obs;
  var firstName = ''.obs;

  // --- Payscribe Account Data ---
  var accountNumber = ''.obs;
  var accountName = ''.obs;
  var bankName = ''.obs;

  // --- Loading State ---
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile(); // Load both profile & payscribe account automatically
  }

  /// Fetch user profile and payscribe account from the same API
  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      print("🔑 Retrieved Token for Profile: $token");

      if (token == null) {
        isLoading.value = false;
        return;
      }

      final response = await http.get(
        Uri.parse(APIConstants.profileEndpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("🌐 Profile API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          final userData = data['data'];
          final accounts = userData['virtualAccounts'] as List? ?? [];

          // --- Profile Info ---
          fullName.value = '${userData['firstName']} ${userData['lastName']}';
          email.value = userData['email'];
          firstName.value = userData['firstName'];

          // --- Payscribe Account ---
          final payscribeAccount = accounts.firstWhere(
                (acc) => acc['provider'] == 'payscribe',
            orElse: () => null,
          );

          if (payscribeAccount != null) {
            accountNumber.value = payscribeAccount['accountNumber'] ?? '';
            accountName.value = payscribeAccount['accountName'] ?? '';
            bankName.value = payscribeAccount['bankName'] ?? '';
            print("🏦 Payscribe Account Found: ${payscribeAccount['accountNumber']}");
          } else {
            print("⚠️ No Payscribe account found.");
          }
        } else {
          print("❌ Profile fetch failed: ${data['msg']}");
        }
      } else {
        print("❌ Server Error: ${response.statusCode}");
      }
    } catch (e) {
      print('🚨 Error fetching profile: $e');
    } finally {
      isLoading.value = false;
      print("✅ Profile loading completed");
    }
  }

  /// Clear stored user and account data
  void clearData() {
    fullName.value = '';
    email.value = '';
    firstName.value = '';
    accountNumber.value = '';
    accountName.value = '';
    bankName.value = '';
    print("🔄 Clearing all profile and account data...");
  }
}
