import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smatpay/features/smatpay/brands/transaction/transaction_model.dart';

class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();

  final isLoading = false.obs;
  final transactions = <TransactionModel>[].obs;
  final hasError = false.obs;
  final currentPage = 1.obs;
  final totalPages = 1.obs;

  @override
  void onInit() {
    fetchTransactions();
    super.onInit();
  }

  Future<void> fetchTransactions({int page = 1}) async {
    try {
      isLoading(true);
      hasError(false);
      print('Fetching transactions for page $page...');

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await http.get(
        Uri.parse('https://api.smatpay.live/history?perPage=10&page=$page'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        transactions.assignAll(data.map((item) => TransactionModel.fromJson(item)).toList());

        currentPage.value = jsonResponse['metadata']['page'] ?? 1;
        totalPages.value = (jsonResponse['metadata']['total'] / jsonResponse['metadata']['perPage']).ceil();

        print('Successfully loaded ${transactions.length} transactions');
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      hasError(true);
      print('Error fetching transactions: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadMoreTransactions() async {
    if (currentPage.value < totalPages.value && !isLoading.value) {
      currentPage.value++;
      await fetchTransactions(page: currentPage.value);
    }
  }
  // Add this to your TransactionController class
  TransactionModel? get latestTransaction {
    return transactions.isNotEmpty ? transactions.first : null;
  }
}