import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TTestingWalletBalanceScreen extends StatefulWidget {
  @override
  _TTestingWalletBalanceScreenState createState() =>
      _TTestingWalletBalanceScreenState();
}

class _TTestingWalletBalanceScreenState
    extends State<TTestingWalletBalanceScreen> {
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

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body)['data'];

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

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    if (isLoading) {
      return Center(
        child: TShimmerEffect(
          width: double.infinity,
          height: double.infinity,
          radius: 20,
        ),
      );
    } else if (accountBalance == null) {
      return Center(child: Text('No account balance available.'));
    } else {
      return Scaffold(
        backgroundColor: dark ? TColors.secondary : TColors.lightGrey,
        appBar: TAppBar(
          title: Text('Account Details'),
          showBackArrow: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Account Balance: NGN ${accountBalance!.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      );
    }
  }
}
