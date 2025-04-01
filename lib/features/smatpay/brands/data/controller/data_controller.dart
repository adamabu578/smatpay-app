import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

    try {
      final token = await _getToken();
      if (token == null) return;

      final response = await http.get(
        Uri.parse('https://api.smatpay.live/data/bundle/${selectedNetwork.value}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          final bundles = List<Map<String, dynamic>>.from(data['data']);
          dataBundles.assignAll(bundles);

          // Select first bundle if available
          if (bundles.isNotEmpty) {
            selectedBundle.value = bundles.first;
          }
        } else {
          Get.snackbar('Error', data['message'] ?? 'Failed to fetch bundles');
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch bundles. Status: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load bundles: $e');
    } finally {
      isLoading(false);
    }
  }

  void selectNetwork(String network) {
    if (selectedNetwork.value == network) return;
    selectedNetwork.value = network;
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
      print('🚀 Starting data purchase...');
      print('📱 Phone: $phoneNumber');
      print('📦 Bundle: $bundleCode');
      print('🌐 Network: $network');

      if (network == null) {
        throw Exception('Network not selected');
      }

      isLoading(true);
      transactionStatus.value = null;
      transactionId.value = null;

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      print('🔑 Token: ${token.isNotEmpty ? "Exists" : "Missing"}');

      if (token.isEmpty) {
        throw Exception('Authentication token not found');
      }

      final response = await http.post(
        Uri.parse('https://api.smatpay.live/data'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'network': network,
          'phoneNumber': phoneNumber,
          'bundleCode': bundleCode,
        }),
      );

      print('📊 Response Status: ${response.statusCode}');
      print('📦 Response Body: ${response.body}');

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        transactionStatus.value = 'success';
        transactionId.value = responseData['data']['transactionId'];
        print('✅ Purchase successful!');
      } else if (response.statusCode == 402) {
        transactionStatus.value = 'insufficient_balance';
        print('❌ Insufficient balance');
      } else {
        transactionStatus.value = 'failed';
        transactionId.value = responseData['data']?['transactionId'];
        print('❌ Purchase failed');
      }
    } catch (e) {
      transactionStatus.value = 'error';
      print('‼️ Exception during purchase: $e');
      Get.snackbar('Error', 'Purchase failed: ${e.toString()}');
    } finally {
      isLoading(false);
      print('🏁 Purchase process completed');
    }
  }
}