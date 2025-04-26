import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  static Future<Map<String, String>> getAccountParameters() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'accountNumber': prefs.getString('user_account_number') ?? '',
      'bankCode': prefs.getString('user_bank_code') ?? '',
    };
  }

  static Future<void> saveAccountParameters({
    required String accountNumber,
    required String bankCode,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_account_number', accountNumber);
    await prefs.setString('user_bank_code', bankCode);
  }
}