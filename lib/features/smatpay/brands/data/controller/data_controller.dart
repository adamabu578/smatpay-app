import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/constants/api_constants.dart';

class DataBundleController extends GetxController {
  final isLoading = false.obs;
  final dataBundles = <Map<String, dynamic>>[].obs;
  final selectedBundle = Rxn<Map<String, dynamic>>();
  final selectedNetwork = 'mtn'.obs;
  final phoneNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataBundles();
  }

  Future<void> fetchDataBundles() async {
    isLoading(true);
    dataBundles.clear();
    selectedBundle.value = null;
    selectedBundle.refresh();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      print('🔑 Auth Token: ${token != null ? "Found (${token.length} chars)" : "NOT FOUND"}');
      
      if (token == null || token.isEmpty) {
        print('❌ No auth token found in SharedPreferences');
        Get.snackbar('Error', 'Authentication required. Please log in.');
        return;
      }

      final url = '${APIConstants.dataBundleEndpoint}/${selectedNetwork.value}';
      print('🔗 Fetching from: $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      print('📊 Status Code: ${response.statusCode}');
      print('📦 Response Body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final data = json.decode(response.body);
          print('✅ Decoded JSON: $data');
          
          // Check if response is a list (direct array response)
          if (data is List) {
            print('📋 Response is a list');
            final bundles = List<Map<String, dynamic>>.from(data);
            dataBundles.assignAll(bundles);

            if (bundles.isNotEmpty) {
              selectedBundle.value = Map<String, dynamic>.from(bundles.first);
              selectedBundle.refresh();
            }
          }
          // Check if response is object with 'data' field
          else if (data is Map && data['data'] != null) {
            print('📋 Response has data field');
            final bundles = List<Map<String, dynamic>>.from(data['data']);
            dataBundles.assignAll(bundles);

            if (bundles.isNotEmpty) {
              selectedBundle.value = Map<String, dynamic>.from(bundles.first);
              selectedBundle.refresh();
            }
          }
          // Check if response is directly list of bundles
          else if (data is Map) {
            print('⚠️ Response structure: ${data.keys.toList()}');
            Get.snackbar('Error', 'Unexpected response format. Check logs.');
          }
        } catch (parseError) {
          print('❌ JSON Parse Error: $parseError');
          Get.snackbar('Error', 'Failed to parse response: $parseError');
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        Get.snackbar('Error', 'Failed to fetch bundles. Status: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      print('❌ Exception: $e');
      Get.snackbar('Error', 'Failed to load bundles: $e');
    } finally {
      isLoading(false);
    }
  }

  void selectNetwork(String network) {
    if (selectedNetwork.value == network) return;

    selectedNetwork.value = network;
    selectedBundle.value = null;
    selectedBundle.refresh(); // ✅ reset UI
    fetchDataBundles();
  }


  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'Authentication required');
      return null;
    }
    return token;
  }

  Map<String, dynamic>? get selectedBundleDetails => selectedBundle.value;
  String get selectedNetworkType => selectedNetwork.value;
}


class DataPurchaseController extends GetxController {
  final isLoading = false.obs;
  final transactionStatus = Rx<String?>(null);
  final transactionId = Rx<String?>(null);

  Future<void> purchaseData({
    required String? network,
    required String phoneNumber,
    required String bundleCode,
  }) async {
    try {
      print('\n' + '='*60);
      print('🚀 STARTING DATA PURCHASE');
      print('='*60);
      print('📱 Phone: $phoneNumber');
      print('📦 Bundle Code: $bundleCode');
      print('🌐 Network: $network');

      if (network == null || network.isEmpty) {
        print('❌ Error: Network not selected');
        throw Exception('Network not selected');
      }

      isLoading(true);
      transactionStatus.value = null;
      transactionId.value = null;

      // Get token
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      print('🔑 Token: ${token.isNotEmpty ? "Found (${token.length} chars)" : "❌ MISSING"}');

      if (token.isEmpty) {
        print('❌ Error: Authentication token not found');
        throw Exception('Authentication token not found');
      }

      // Prepare request
      final url = APIConstants.dataEndpoint;
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      final body = json.encode({
        'network': network,
        'phoneNumber': phoneNumber,
        'bundleCode': bundleCode,
      });

      print('\n📤 REQUEST DETAILS:');
      print('URL: $url');
      print('Headers: $headers');
      print('Body: $body');

      // Send request
      print('\n⏳ Sending request...');
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      ).timeout(const Duration(seconds: 30));

      print('\n📥 RESPONSE RECEIVED:');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Parse response
      try {
        final responseData = json.decode(response.body);
        print('✅ Response parsed successfully');
        print('Response data: $responseData');

        if (response.statusCode == 200) {
          final status = responseData['status'] ?? '';
          print('\n✅ SUCCESS! Status: $status');
          
          transactionStatus.value = 'success';
          transactionId.value = responseData['data']?['transactionId'] ?? '';
          
          print('💰 Transaction ID: ${transactionId.value}');
          Get.snackbar(
            'Success',
            'Transaction successful!\nID: ${transactionId.value}',
            duration: const Duration(seconds: 4),
          );
        } else if (response.statusCode == 402) {
          print('\n⚠️ Insufficient balance');
          transactionStatus.value = 'insufficient_balance';
          Get.snackbar('Error', 'Insufficient balance. Please fund your wallet.');
        } else {
          print('\n❌ Transaction failed with status ${response.statusCode}');
          transactionStatus.value = 'failed';
          transactionId.value = responseData['data']?['transactionId'];
          
          final message = responseData['msg'] ?? responseData['message'] ?? 'Transaction failed';
          Get.snackbar('Error', message);
        }
      } catch (parseError) {
        print('\n❌ JSON Parse Error: $parseError');
        transactionStatus.value = 'error';
        Get.snackbar('Error', 'Failed to parse response: $parseError');
      }
    } catch (e) {
      print('\n❌ EXCEPTION: $e');
      print(e.runtimeType);
      transactionStatus.value = 'error';
      Get.snackbar('Error', 'Purchase failed: ${e.toString()}');
    } finally {
      isLoading(false);
      print('\n' + '='*60);
      print('🏁 PURCHASE PROCESS COMPLETED');
      print('Final Status: ${transactionStatus.value}');
      print('='*60 + '\n');
    }
  }
  void resetTransaction() {
    transactionStatus.value = null;
    transactionId.value = null;
  }

// Add this to handle different status cases more clearly
  String? get formattedStatus {
    switch (transactionStatus.value) {
      case 'success':
        return null; // No message needed as we navigate away
      case 'insufficient_balance':
        return 'Insufficient balance. Please fund your wallet.';
      case 'failed':
      case 'error':
        return 'Transaction failed. Please try again.';
      default:
        return null;
    }
  }
}