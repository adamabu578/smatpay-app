import 'dart:convert';
import 'package:http/http.dart' as http;

// Paystack Secret Key (replace with your own)
final String _paystackSecretKey =
    'sk_test_755ce9477ba4f1f8c8382b7cc02296765d0a48df';
// final String _paystackSecretKey =
//  'sk_test_755ce9477ba4f1f8c8382b7cc02296765d0a48df';

// Function to fetch the account balance
Future<double> fetchAccountBalance() async {
  final url =
      'https://api.paystack.co/balance'; // Paystack API endpoint for balance
  final headers = {
    'Authorization': 'Bearer $_paystackSecretKey',
  };

  // Send a GET request to the Paystack API
  final response = await http.get(Uri.parse(url), headers: headers);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['data'];
    if (data.isNotEmpty) {
      return data[0]['balance'] / 100.0; // Convert from kobo to Naira
    } else {
      throw Exception('No balance data found');
    }
  } else {
    throw Exception('Failed to load account balance');
  }
}
