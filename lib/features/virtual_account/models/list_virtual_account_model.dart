import 'dart:convert';
import 'package:http/http.dart' as http;

// Class representing a Dedicated Account
class TListVirtualAccount {
  final String accountName; // Holds the account holder's name
  final String accountNumber; // Holds the account number
  final String bankName; // Holds the bank name associated with the account
  final double accountBalance; // Add account balance field

  // Constructor for TListVirtualAccount class
  TListVirtualAccount({
    required this.accountName, // The account holder's name must be provided
    required this.accountNumber, // The account number must be provided
    required this.bankName, // The bank name must be provided
    required this.accountBalance, // Initialize balance
  });

  // Factory method to create a TListVirtualAccount instance from JSON data
  factory TListVirtualAccount.fromJson(Map<String, dynamic> json) {
    return TListVirtualAccount(
      accountName: json['account_name'], // Extracts 'account_name' from JSON
      accountNumber:
          json['account_number'], // Extracts 'account_number' from JSON
      bankName: json['bank']
          ['name'], // Extracts 'bank' and then 'name' from JSON
      accountBalance: json['balance'] != null
          ? json['balance'] /
              100.0 // Assuming balance is in kobo (convert to Naira)
          : 0.0, // Handle case if balance is missing
    );
  }
}

// Paystack Secret Key (replace with your own)
final String _paystackSecretKey =
    'sk_test_755ce9477ba4f1f8c8382b7cc02296765d0a48df';
// final String _paystackSecretKey =
//     'sk_test_755ce9477ba4f1f8c8382b7cc02296765d0a48df';

// Function to fetch the list of dedicated virtual accounts
Future<List<TListVirtualAccount>> fetchTListVirtualAccounts() async {
  final url =
      'https://api.paystack.co/dedicated_account'; // Paystack API endpoint for listing virtual accounts

  final headers = {
    'Authorization':
        'Bearer $_paystackSecretKey', // Authorization header with Paystack secret key
  };

  // Sends a GET request to the Paystack API
  final response = await http.get(Uri.parse(url), headers: headers);

  // If the response status code is 200 (OK), process the response
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)[
        'data']; // Decodes the response body and extracts the 'data' field
    // Maps each JSON object in the data to a TListVirtualAccount object, and returns the list of accounts
    return data.map((json) => TListVirtualAccount.fromJson(json)).toList();
  } else {
    // If the API call fails, throw an exception with an error message
    throw Exception('Failed to load dedicated accounts');
  }
}
