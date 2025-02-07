import 'dart:convert';
import 'package:http/http.dart' as http;

class DataService {
  static const String _apiUrl = "https://smedata.ng/wp-json/api/v1/";
  static const String _apiToken = "86097ee7d1599a5043e519ca2";

  final String _paystackSecretKey =
      'sk_test_755ce9477ba4f1f8c8382b7cc02296765d0a48df';

  Future<Map<String, dynamic>> purchaseData(
    String operator,
    String plan,
    String amount,
    String phoneNumber,
  ) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiToken',
      },
      body: json.encode({
        'network': operator, // MTN, Glo, Airtel, etc.
        'plan': plan, // The selected data plan
        'amount': amount, // The amount for the plan
        'phone_number': phoneNumber, // Recipient's phone number
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Process the response
    } else {
      print('Error: ${response.statusCode}');
      print('Response Body: ${response.body}');

      throw Exception('Failed to purchase data');
    }
  }

  Future<bool> checkAccountBalance() async {
    final url = 'https://api.paystack.co/balance';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $_paystackSecretKey',
      },
    );

    if (response.statusCode == 200) {
      final balanceData = jsonDecode(response.body);
      return balanceData['data']['balance'] > 0; // Adjust based on your needs
    } else {
      // Print the response body for debugging
      print(
          'Failed to fetch balance: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to fetch account balance');
    }
  }
}
