import 'package:flutter/material.dart'; // Import Flutter material design library for UI components.
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore for database operations.
import 'package:flutter/services.dart';
import 'package:http/http.dart'
    as http; // Import HTTP package for API requests.
import 'dart:convert'; // Import Dart's convert library for JSON handling.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:smatpay/utils/popups/loaders.dart'; // Add this for user authentication

// The main screen for displaying account details.
class TFetchAccountDetailScreen extends StatefulWidget {
  @override
  _TFetchAccountDetailScreenState createState() =>
      _TFetchAccountDetailScreenState();
}

// State class for TFetchAccountDetailScreen that manages the UI and logic.
class _TFetchAccountDetailScreenState extends State<TFetchAccountDetailScreen> {
  String? userId; // To hold the current user's ID.
  int? dvaId; // To hold the DVA ID retrieved from Firestore.
  Map<String, dynamic>?
      accountDetails; // To hold the account details fetched from Paystack.
  bool isLoading = true; // To manage loading state.

  @override
  void initState() {
    super.initState();
    fetchAccountDetails(); // Fetch account details when the screen initializes.
  }

  // Function to fetch account details based on the current user's ID.
  Future<void> fetchAccountDetails() async {
    try {
      // Automatically fetch the current user's ID.
      User? currentUser =
          FirebaseAuth.instance.currentUser; // Get the current user.
      if (currentUser != null) {
        // Check if a user is logged in.
        userId = currentUser.uid; // Get the user ID from Firebase Auth.
        dvaId = await fetchDvaIdFromFirestore(
            userId!); // Fetch DVA ID from Firestore.
        if (dvaId != null) {
          // Check if DVA ID was retrieved successfully.
          accountDetails = await fetchDedicatedAccount(
              dvaId!); // Fetch account details from Paystack API.
        }
      } else {
        print('No user is logged in.'); // Log if no user is found.
      }
    } catch (e) {
      print(
          'Error fetching account details: $e'); // Log any error that occurs during fetching.
    } finally {
      setState(() {
        isLoading = false; // Stop loading once the data fetch is complete.
      });
    }
  }

  // Function to fetch the DVA ID from Firestore based on the user ID.
  Future<int?> fetchDvaIdFromFirestore(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('PaystackUsers') // Specify the Firestore collection.
              .doc(userId) // Access the document with the user ID.
              .get(); // Get the document snapshot.

      if (documentSnapshot.exists) {
        // Check if the document exists.
        Map<String, dynamic>? data =
            documentSnapshot.data(); // Get the data from the document.
        return data?['dvaId']; // Return the DVA ID from the data.
      } else {
        print(
            'No document found with ID: $userId'); // Log if the document does not exist.
      }
    } catch (e) {
      print(
          'Error fetching DVA ID from Firestore: $e'); // Log any error that occurs during fetching.
    }
    return null; // Return null if no DVA ID is found or an error occurs.
  }

  // Function to fetch dedicated account details from Paystack API using DVA ID.
  Future<Map<String, dynamic>?> fetchDedicatedAccount(int dvaId) async {
    final String _paystackSecretKey =
        'sk_test_755ce9477ba4f1f8c8382b7cc02296765d0a48df'; // Replace with your live secret key.
    String url =
        'https://api.paystack.co/dedicated_account/$dvaId'; // Construct the API URL.

    try {
      // Make a GET request to the Paystack API.
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer $_paystackSecretKey', // Add authorization header.
        },
      );
      if (response.statusCode == 200) {
        // Check if the response is successful.
        var responseData =
            json.decode(response.body)['data']; // Decode the JSON response.
        print('API Response: $responseData'); // Log the full API response.
        return responseData; // Return the account details.
      } else {
        print(
            'Failed to fetch data: ${response.statusCode} - ${response.body}'); // Log if the request failed.
      }
    } catch (e) {
      print(
          'Error making API request: $e'); // Log any error that occurs during the API request.
    }
    return null; // Return null if an error occurs or data could not be fetched.
  }

  void _copyToClipboard(String text) {
    try {
      Clipboard.setData(
          ClipboardData(text: text)); // Attempt to copy the text to clipboard

// Show Success Message
      TLoaders.successSnackBar(
          title: 'Hurray', message: '$text copied to clipboard!', duration: 2);
    } catch (e) {
      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Failed to copy: $e');
    }
  }

  // Build method to create the UI for this screen.
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    if (isLoading) {
      // Check if the data is still loading.
      return Center(
          child: CircularProgressIndicator()); // Show loading indicator.
    } else if (accountDetails == null || accountDetails!.isEmpty) {
      // Check if account details are available.
      return Center(
          child: Text(
              'No account details available.')); // Show message if no details are found.
    } else {
      // Display account details in a structured format.
      return
          //    Scaffold(
          //     appBar:  AppBar(title: Text('Account Details')), // App bar with title.
          //    body:
          Padding(
        padding: EdgeInsets.all(25.0), // Padding around the content.
        child: Container(
          height: 260,
          decoration: BoxDecoration(
              color: dark ? TColors.secondary : TColors.white,
              border: Border.all(
                color: dark ? TColors.secondary : TColors.lightGrey,
              ),
              borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Align items to the start of the column.
            children: [
              Text(
                'Your NGN Bank Account Details',
                style: Theme.of(context).textTheme.titleLarge!.apply(
                      color: dark ? TColors.white : TColors.black,
                    ),
              ),
              SizedBox(
                height: 20,
              ),

              Text(
                'Account Name',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColors.primary : TColors.primary,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${accountDetails!['account_name']}', // Display account name.
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: dark ? TColors.white : TColors.black,
                          // fontSizeFactor:
                          //     1.2, // Increase the font size by a factor (1.2 = 20% increase)
                        ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () =>
                        _copyToClipboard(accountDetails!['account_name']),
                    child: Icon(
                      Icons.copy,
                      color: TColors.primary,
                      size: 20,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Account Number',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColors.primary : TColors.primary,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${accountDetails!['account_number']}',
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: dark ? TColors.white : TColors.black,
                          fontSizeFactor:
                              1.2, // Increase the font size by a factor (1.2 = 20% increase)
                        ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () =>
                        _copyToClipboard(accountDetails!['account_number']),
                    child: Icon(
                      Icons.copy,
                      color: TColors.primary,
                      size: 20,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Bank',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColors.primary : TColors.primary,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${accountDetails!['bank']['name']}',
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: dark ? TColors.white : TColors.black,
                          fontSizeFactor:
                              1.2, // Increase the font size by a factor (1.2 = 20% increase)
                        ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () =>
                        _copyToClipboard(accountDetails!['bank']['name']),
                    child: Icon(
                      Icons.copy,
                      color: TColors.primary,
                      size: 20,
                    ),
                  ),
                ],
              ),
              // Text(
              //     'Account Name: ${accountDetails!['account_name']}', // Display account name.
              //     style: TextStyle(fontSize: 18)),
              // Text(
              //     'Account Number: ${accountDetails!['account_number']}', // Display account number.
              //     style: TextStyle(fontSize: 18)),
              // Text(
              //     'Bank Name: ${accountDetails!['bank']['name']}', // Display bank name.
              //     style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      );
      //   );
    }
  }
}
