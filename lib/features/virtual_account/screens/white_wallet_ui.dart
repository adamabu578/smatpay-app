import 'package:flutter/material.dart'; // Import Flutter material design package for UI components
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore package for database access
import 'package:http/http.dart'
    as http; // Import HTTP package for making API requests
import 'dart:convert'; // Import Dart's JSON package for encoding/decoding JSON
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart'; // Import Firebase Auth package for user authentication

// Define a StatefulWidget for the withdrawal screen
class TWalletBalanceWhiteScreen extends StatefulWidget {
  @override
  _TWalletBalanceWhiteScreenState createState() =>
      _TWalletBalanceWhiteScreenState();
}

// State class for TWalletBalanceWhiteScreen
class _TWalletBalanceWhiteScreenState extends State<TWalletBalanceWhiteScreen> {
  String? userId;
  String? customerId;
  double? accountBalance;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAccountDetails();
  }

  Future<void> fetchAccountDetails() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        userId = currentUser.uid;
        customerId = await fetchCustomerIdFromFirestore(userId!);

        // Fetch balance using Customer ID
        if (customerId != null) {
          accountBalance =
              await fetchAccountBalanceFromTransactions(customerId);

          // Update the balance in Firestore
          if (accountBalance != null) {
            await updateBalanceInFirestore(userId!, accountBalance!);
          }
        }
      } else {
        print('No user is logged in.');
      }
    } catch (e) {
      print('Error fetching account details: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String?> fetchCustomerIdFromFirestore(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('PaystackUsers')
              .doc(userId)
              .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data = documentSnapshot.data();
        var customerIdValue =
            data?['customerId']; // Fetch the customer ID from Firestore
        if (customerIdValue is int) {
          return customerIdValue
              .toString(); // Convert to string if it's an integer
        } else if (customerIdValue is String) {
          return customerIdValue; // Return as is if it's already a string
        }
      } else {
        print('No document found with ID: $userId');
      }
    } catch (e) {
      print('Error fetching Customer ID from Firestore: $e');
    }
    return null;
  }

  Future<double?> fetchAccountBalanceFromTransactions(
      String? customerId) async {
    final String _paystackSecretKey =
        'sk_test_755ce9477ba4f1f8c8382b7cc02296765d0a48df'; // Use your test secret key
    String url = 'https://api.paystack.co/transaction?customer=$customerId';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $_paystackSecretKey',
        },
      );

      print('Fetching transactions from: $url');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body)['data'];

        print('Transactions: $responseData');

        double totalCredits = 0;
        double totalDebits = 0;

        for (var transaction in responseData) {
          if (transaction['status'] == 'success') {
            totalCredits += transaction['amount'] / 100;
          } else if (transaction['status'] == 'failed') {
            totalDebits += transaction['amount'] / 100;
          }
        }

        double balance = totalCredits - totalDebits;
        print('Account balance: $balance');
        return balance;
      } else {
        print(
            'Failed to fetch transactions: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error making API request for transactions: $e');
    }
    return null;
  }

  Future<void> updateBalanceInFirestore(String userId, double balance) async {
    try {
      await FirebaseFirestore.instance
          .collection('PaystackUsers')
          .doc(userId)
          .update({'accountBalance': balance});
      print('Balance updated successfully in Firestore.');
    } catch (e) {
      print('Error updating balance in Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);
    if (isLoading) {
      return TShimmerEffect(
        width: 150,
        height: 5,
        radius: 15,
      );
    } else if (accountBalance == null) {
      return Center(child: Text('No account balance available.'));
    } else {
      return
          // Scaffold(
          //   backgroundColor: dark ? TColors.secondary : TColors.lightGrey,
          //   appBar: TAppBar(
          //     title: Text('Account Details'),
          //     showBackArrow: true,
          //   ),
          //   body:
          // Padding(
          //     padding: EdgeInsets.all(16.0),
          //     child:
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '₦ ${accountBalance!.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.headlineLarge!.apply(
                  color: TColors.softGrey,
                  fontFamily: 'NotoSans',
                ),
          ),
        ],
      );
      // );
      //   );
    }
  }
}
