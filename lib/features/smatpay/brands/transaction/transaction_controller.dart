import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
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
  String? _currentUserId;

  @override
  void onInit() {
    _initUserAndFetch();
    super.onInit();
  }

  Future<void> _initUserAndFetch() async {
    final prefs = await SharedPreferences.getInstance();
    _currentUserId = prefs.getString('user_id');
    await fetchTransactions();
  }

  Future<void> clearCache() {
    transactions.clear();
    currentPage.value = 1;
    totalPages.value = 1;
    return Future.value();
  }

  Future<void> fetchTransactions({int page = 1, bool forceRefresh = false}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentUser = prefs.getString('user_id');

      // Clear cache if user changed or forced refresh
      if (forceRefresh || _currentUserId != currentUser) {
        await clearCache();
        _currentUserId = currentUser;
      }

      isLoading(true);
      hasError(false);
      debugPrint('Fetching transactions for user $_currentUserId, page $page...');

      final token = prefs.getString('auth_token');
      if (token == null) throw Exception('Authentication required');

      final response = await http.get(
        Uri.parse('https://api.smatpay.live/history?perPage=10&page=$page'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 30));

      debugPrint('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];

        if (page == 1) {
          transactions.assignAll(data.map((item) => TransactionModel.fromJson(item)));
        } else {
          transactions.addAll(data.map((item) => TransactionModel.fromJson(item)));
        }

        currentPage.value = jsonResponse['metadata']['page'] ?? 1;
        totalPages.value = (jsonResponse['metadata']['total'] / jsonResponse['metadata']['perPage']).ceil();
      } else {
        throw Exception('Failed to load transactions: ${response.statusCode}');
      }
    } on TimeoutException {
      hasError(true);
      throw Exception('Request timed out');
    } catch (e) {
      hasError(true);
      debugPrint('Transaction fetch error: $e');
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadMoreTransactions() async {
    if (currentPage.value < totalPages.value && !isLoading.value) {
      await fetchTransactions(page: currentPage.value + 1);
    }
  }

  TransactionModel? get latestTransaction => transactions.isNotEmpty ? transactions.first : null;
}