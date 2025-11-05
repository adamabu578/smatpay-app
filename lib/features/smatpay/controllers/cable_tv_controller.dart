import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cable_plan_model.dart';
import '../models/verify_smartcard_model.dart';

class CableTvController extends GetxController {
  // Observables
  final RxString selectedProvider = ''.obs;
  final RxList<CablePlan> plans = <CablePlan>[].obs;
  final Rxn<CablePlan> selectedPlan = Rxn<CablePlan>();
  final Rx<SmartCardData?> customerDetails = Rxn<SmartCardData>();
  final RxString amount = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isVerifying = false.obs;
  final RxString errorMessage = ''.obs;

  final TextEditingController smartcardController = TextEditingController();

  // Token management
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshTokenKey);
  }

  Future<bool> verifySmartcard() async {
    final provider = selectedProvider.value;
    final cardNumber = smartcardController.text.trim();

    if (provider.isEmpty) {
      errorMessage.value = "Please select a provider first";
      return false;
    }

    if (cardNumber.isEmpty) {
      errorMessage.value = "Please enter smartcard number";
      return false;
    }

    isVerifying.value = true;
    errorMessage.value = '';

    try {
      final token = await getToken();
      if (token == null) {
        errorMessage.value = "Authentication required. Please login";
        return false;
      }

      final response = await http.post(
        Uri.parse("https://api.smatpay.live/tv/verify-smart-card"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'provider': provider,
          'cardNumber': cardNumber,
        }),
      ).timeout(const Duration(seconds: 30));

      final responseData = json.decode(response.body);
      debugPrint('Verification Response: $responseData');

      if (response.statusCode == 200) {
        final verificationResponse = VerifySmartCardResponse.fromJson(responseData);
        if (verificationResponse.success) {
          customerDetails.value = verificationResponse.data;
          return true;
        } else {
          errorMessage.value = verificationResponse.message;
          return false;
        }
      } else if (response.statusCode == 401) {
        errorMessage.value = "Session expired. Please login again";
        await clearTokens();
        return false;
      } else {
        errorMessage.value = responseData['msg'] ?? 'Verification failed';
        return false;
      }
    } catch (e) {
      errorMessage.value = _handleError(e);
      return false;
    } finally {
      isVerifying.value = false;
    }
  }

  Future<bool> fetchPlans() async {
    if (selectedProvider.value.isEmpty) return false;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final token = await getToken();
      if (token == null) {
        errorMessage.value = "Authentication required. Please login";
        return false;
      }

      final response = await http.get(
        Uri.parse("https://api.smatpay.live/tv/plans?provider=${selectedProvider.value}"),
        headers: {'Authorization': 'Bearer $token'},
      ).timeout(const Duration(seconds: 30));

      final responseData = json.decode(response.body);
      debugPrint('Plans Response: $responseData');

      if (response.statusCode == 200) {
        final plansResponse = PlansResponse.fromJson(responseData);
        if (plansResponse.success) {
          plans.value = plansResponse.plans;
          return true;
        } else {
          errorMessage.value = plansResponse.message;
          return false;
        }
      } else if (response.statusCode == 401) {
        errorMessage.value = "Session expired. Please login again";
        await clearTokens();
        return false;
      } else {
        errorMessage.value = responseData['msg'] ?? 'Failed to load plans';
        return false;
      }
    } catch (e) {
      errorMessage.value = _handleError(e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  String _handleError(dynamic e) {
    if (e is http.ClientException) {
      return "Network error. Please check your connection";
    } else if (e is TimeoutException) {
      return "Request timed out. Please try again";
    } else if (e is FormatException) {
      return "Invalid server response";
    }
    return "An unexpected error occurred";
  }

  @override
  void onClose() {
    smartcardController.dispose();
    super.onClose();
  }
}