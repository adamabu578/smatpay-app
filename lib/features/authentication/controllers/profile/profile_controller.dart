import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  var fullName = ''.obs;
  var email = ''.obs;
  var isLoading = true.obs;
  var firstName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile(); // Changed from fetchProfile to loadUserProfile
  }

  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      print("🔑 Retrieved Token for Profile: $token");

      if (token == null) {
        isLoading.value = false;
        return;
      }

      final response = await http.get(
        Uri.parse('https://api.smatpay.live/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("🌐 Profile API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          fullName.value = '${data['data']['firstName']} ${data['data']['lastName']}';
          email.value = data['data']['email'];
          firstName.value = data['data']['firstName'];
        } else {
          print("❌ Profile fetch failed: ${data['msg']}");
        }
      }
    } catch (e) {
      print('🚨 Error fetching profile: $e');
    } finally {
      isLoading.value = false;
      print("✅ Profile loading completed");
    }
  }

  void clearData() {
    fullName.value = '';
    email.value = '';
    firstName.value = '';
    print("🔄 Clearing profile data...");
  }
}