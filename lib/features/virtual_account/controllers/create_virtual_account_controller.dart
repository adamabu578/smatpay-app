import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../../../utils/constants/api_constants.dart';
import '../screens/success_screen.dart';


  class CreateVirtualAccountController extends GetxController {
    static CreateVirtualAccountController get instance => Get.find();

    final isLoading = false.obs;
    final isSuccess = false.obs;
    final accountData = <String, dynamic>{}.obs;

    Future<void> createVirtualAccount() async {
      try {
        isLoading.value = true;
        print("⏳ Starting virtual account creation (Payscribe)...");

        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('auth_token');

        if (token == null) {
          print("❌ No authentication token found");
          throw Exception("Authentication token not found");
        }

        final url = Uri.parse(APIConstants.virtualAccountEndpoint);
        final body = jsonEncode({
          "nuban_provider": "payscribe", // only Payscribe
        });

        print("📤 Sending request to: $url");
        print("📝 Request body: $body");


        final response = await http
            .post(
          url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: body,
        )
            .timeout(const Duration(seconds: 30));

        print("✅ Response received: ${response.statusCode}");
        print("📄 Response body: ${response.body}");
        print("🔐 Authorization: Bearer ${token.substring(0, 8)}...");
        print("🔍 Full response: ${response.body}");

        final data = jsonDecode(response.body);

        if (response.statusCode == 200 && data['status'] == 'success') {
          print("🎉 Virtual account created successfully!");
          accountData.value = data['data'] ?? {};
          isSuccess.value = true;

          // Navigate to success screen with account details
          Get.off(() => VirtualAccountSuccessScreen(
            accountData: accountData.value,
          ));
        } else {
          print("❌ Failed to create virtual account: ${data['msg']}");
          throw Exception(data['msg'] ?? 'Failed to create virtual account');
        }
      } on TimeoutException {
        print("⏱️ Request timed out");
        Get.snackbar(
          'Timeout',
          'Request took too long. Please try again',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } catch (e) {
        print("🚨 Error creating virtual account: $e");
        Get.snackbar(
          'Error',
          e.toString().replaceAll('Exception: ', ''),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        rethrow;
      } finally {
        isLoading.value = false;
        print("🔄 Virtual account creation process completed");

      }
    }
  }

class AccountController {
  static const String _profileUrl = APIConstants.profileEndpoint;
  static const String _cacheKey = 'cached_profile_data';
  static const int _timeoutSeconds = 15;

  // Memory cache
  Map<String, dynamic>? _memoryCache;

  Future<Map<String, dynamic>> fetchProfileDetails({bool forceRefresh = false}) async {
    try {
      // If forcing refresh, clear caches first
      if (forceRefresh) {
        await clearCache();
      }

      // 1. First try memory cache
      if (_memoryCache != null && !forceRefresh) {
        debugPrint('💾 Returning memory-cached profile data');
        return _memoryCache!;
      }

      // 2. Then try persistent cache (only if not forcing refresh)
      if (!forceRefresh) {
        final prefs = await SharedPreferences.getInstance();
        final cachedJson = prefs.getString(_cacheKey);

        if (cachedJson != null) {
          debugPrint('📦 Returning persistent-cached profile data');
          _memoryCache = json.decode(cachedJson);
          return _memoryCache!;
        }
      }

      // 3. Finally fetch from network
      debugPrint('🌐 Fetching fresh profile data from API...');
      final token = await _getAuthToken();

      final response = await http.get(
        Uri.parse(_profileUrl),
        headers: _buildHeaders(token),
      ).timeout(const Duration(seconds: _timeoutSeconds));

      final data = _handleResponse(response);

      // Update both caches
      _memoryCache = data;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_cacheKey, json.encode(data));
      debugPrint('✅ Profile data cached in memory and storage');

      return data;
    } on TimeoutException {
      debugPrint('⏱️ Request timed out after $_timeoutSeconds seconds');
      throw Exception('Request timeout. Please check your connection');
    } on http.ClientException catch (e) {
      debugPrint('📡 Network error: ${e.message}');
      throw Exception('Network unavailable. Please check your connection');
    } on FormatException catch (e) {
      debugPrint('🔄 JSON decode error: $e');
      throw Exception('Data format error. Please try again');
    } catch (e) {
      debugPrint('⚠️ Unexpected error: $e');
      throw Exception('Failed to load profile: ${e.toString()}');
    }
  }

  Future<void> clearCache() async {
    debugPrint('🧹 Clearing profile data cache');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
    _memoryCache = null;
  }

  Future<String> _getAuthToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      return token;
    } catch (e) {
      debugPrint('🔐 Auth token error: $e');
      throw Exception('Authentication required. Please login again');
    }
  }

  Map<String, String> _buildHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode != 200) {
      throw Exception('Server responded with status ${response.statusCode}');
    }

    try {
      final responseData = json.decode(response.body);

      if (responseData['status']?.toString().toLowerCase() != 'success') {
        throw Exception(responseData['msg'] ?? 'Request failed');
      }

      return responseData['data'] ?? {};
    } on FormatException {
      throw Exception('Invalid server response format');
    }
  }

  // For testing/debug purposes
  @visibleForTesting
  Future<bool> hasCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_cacheKey);
  }
}