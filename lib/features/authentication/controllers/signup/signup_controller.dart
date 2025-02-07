import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smatpay/data/repositories/authentication/authentication_repository.dart';
import 'package:smatpay/data/repositories/user/user_repository.dart';
import 'package:smatpay/features/authentication/screens/signup/verify_email.dart';
import 'package:smatpay/features/personalization/models/user_model.dart';
import 'package:smatpay/features/virtual_account/models/customer_model.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/helpers/network_manager.dart';
import 'package:smatpay/utils/popups/full_screen_loader.dart';
import 'package:smatpay/utils/popups/loaders.dart';

class TSignupController extends GetxController {
  static TSignupController get instance => Get.find();

  /// Variables

  final email = TextEditingController(); // Controller for email input
  final lastName = TextEditingController(); // Controller for last name  input
  final username = TextEditingController(); // Controller for username input
  final firstName = TextEditingController(); // Controller for First name input
  final phoneNo = TextEditingController(); // Controller for phone number input
  // final otp = TextEditingController();
  final password = TextEditingController(); // Controller for  password input
  final hidePassword = true.obs; // Observable for hidding/showing password
  final privacyPolicy = true.obs; // Observable for privacy policy acceptance
  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); // Form key for form validation

// Replace with your Paystack secret key
  final String _paystackSecretKey =
      'sk_test_755ce9477ba4f1f8c8382b7cc02296765d0a48df';
  //   final String _paystackSecretKey =
  // 'sk_test_755ce9477ba4f1f8c8382b7cc02296765d0a48df';

  /// THE FUNCTION ATTEMPTS TO FETCH A CUSTOMER FROM PAYSTACK BASED ON THEIR EMAIL

  Future<Map<String, dynamic>?> getCustomerByEmail(String email) async {
    // Define the API URL to fetch customer details from Paystack
    final url = Uri.parse('https://api.paystack.co/customer');

    // Set up the headers required by Paystack's API, including the secret key for authorization
    final headers = {
      'Authorization':
          'Bearer $_paystackSecretKey', // Authorization with your Paystack secret key
      'Content-Type':
          'application/json', // Specifies that the content type is JSON
    };

    // Make an HTTP GET request to fetch all customers from Paystack
    final response = await http.get(url, headers: headers);

    // Check if the request was successful (status code 200 means success)
    if (response.statusCode == 200) {
      // Parse the response body into a JSON object
      final data = jsonDecode(response.body);

      // Extract the list of customers from the response data
      final customers = data['data'] as List;

      // Loop through the list of customers to find the one that matches the given email
      for (var customer in customers) {
        if (customer['email'] == email) {
          // If a customer with the matching email is found, return their details
          return customer;
        }
      }

      // If no customer with the given email is found, return null
      return null;
    } else {
      // If the request fails (non-200 status code), throw an error
      throw Exception('Failed to load customer data');
    }
  }

  /// THIS FUNCTION SENDS A REQUEST TO PAYSTACK'S API TO CREATE A NEW CUSTOMER USING THE PROVIDED TCUSTOMERMODEL.

  Future<Map<String, dynamic>> createPaystackCustomer(
      TCustomerModel customer) async {
    // Define the API endpoint for creating a new customer in Paystack
    final url = Uri.parse('https://api.paystack.co/customer');

    // Set up the request headers, including the authorization using the Paystack secret key
    final headers = {
      'Authorization':
          'Bearer $_paystackSecretKey', // Bearer token for Paystack API access
      'Content-Type':
          'application/json', // Ensures that the request body will be in JSON format
    };

    // Convert the customer model (TCustomerModel) to a JSON-encoded string
    final body = jsonEncode(customer.toJson());

    try {
      // Make an HTTP POST request to create the customer in Paystack
      final response = await http.post(url, headers: headers, body: body);

      // Check if the request was successful (HTTP status code 200 indicates success)
      if (response.statusCode == 200) {
        // Parse the response body from JSON format
        final jsonResponse = jsonDecode(response.body);

        // Return the parsed JSON response as a Map
        return jsonResponse;
      } else {
        // If the request failed (non-200 status code), print the error message from the response body
        print('Failed to create customer: ${response.body}');

        // Throw an exception indicating customer creation failure
        throw Exception('Failed to create customer');
      }
    } catch (e) {
      // Catch any exceptions during the request, log the error, and rethrow the exception
      print('Error creating customer: $e');
      throw e;
    }
  }

  /// THIS FUNCTION SENDS A REQUEST TO THE PAYSTACK API TO CREATE A DEDICATED VIRTUAL ACCOUNT (DVA) FOR A CUSTOMER, USING THEIR CUSTOMER ID AND THE PREFERRED BANK.
  ///
  Future<Map<String, dynamic>> createDVA(
      int customerId, String preferredBank) async {
    final url = Uri.parse('https://api.paystack.co/dedicated_account');
    final headers = {
      'Authorization': 'Bearer $_paystackSecretKey',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'customer': customerId,
      'preferred_bank': preferredBank,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      // Detailed logging
      print('Request URL: $url');
      print('Request Headers: $headers');
      print('Request Body: $body');
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create DVA');
      }
    } catch (e) {
      print('Error creating DVA: $e');
      throw e;
    }
  }

  /// CHECK FOR EXISTING CUSTOMERS, CREATE DEDICATED VIRTUAL ACCOUNTS (DVA), HANDLE NEW CUSTOMER CREATION

// Firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> handleCustomerAndDVA(String userId) async {
    // Create a TCustomerModel instance using the input fields (email, first name, last name, phone number)
    final customer = TCustomerModel(
      email: email.text.trim(),
      firstName: firstName.text.trim(),
      lastName: lastName.text.trim(),
      phone: phoneNo.text.trim(),
    );

    try {
      // Step 1: Check if the customer already exists by querying with the customer's email
      final existingCustomer = await getCustomerByEmail(customer.email);

      int customerId = -1; // Initialize with a default value
      int? dvaId; // Declare as nullable
      String? customerCode; // Declare customerCode as nullable
      String? firstNameOutput;
      String? lastNameOutput;
      String? emailOutput;
      String? phoneOutput; // Declare phone output
      String? accountName;
      String? accountNumber;
      String? bankName;
      String? createdAt;
      String? updatedAt;

      if (existingCustomer != null) {
        // If the customer already exists, retrieve their details
        customerId = int.parse(
            existingCustomer['id'].toString()); // Ensure customerId is an int
        customerCode =
            existingCustomer['customer_code']; // Extract the customer code

        // Extract customer details from the existingCustomer map
        firstNameOutput = existingCustomer['first_name']; // Extract first name
        lastNameOutput = existingCustomer['last_name']; // Extract last name
        emailOutput = existingCustomer['email']; // Extract email
        phoneOutput = existingCustomer['phone']; // Extract phone number

        // Step 2: Create a Dedicated Virtual Account (DVA) for the existing customer
        final dvaResponse = await createDVA(customerId, 'wema-bank');
        dvaId = dvaResponse['data']['id']; // Get the DVA ID from the response

        // Extract account details from the DVA response
        accountName = dvaResponse['data']['account_name']; // Account name
        accountNumber = dvaResponse['data']['account_number']; // Account number
        bankName = dvaResponse['data']['bank']
            ['name']; // Bank name (accessing nested map)
        createdAt = dvaResponse['data']['created_at']; // Created date
        updatedAt = dvaResponse['data']['updated_at']; // Updated date

        print('DVA created for existing customer with DVA ID: $dvaId');
      } else {
        // If the customer does not exist, create a new customer
        final newCustomer = await createPaystackCustomer(customer);

        // Retrieve the new customer's details
        customerId = newCustomer['data']['id'];
        customerCode =
            newCustomer['data']['customer_code']; // Extract the customer code

        // Extract customer details from the newCustomer response
        final customerData =
            newCustomer['data']['customer']; // Access customer data
        firstNameOutput = customerData['first_name']; // Extract first name
        lastNameOutput = customerData['last_name']; // Extract last name
        emailOutput = customerData['email']; // Extract email
        phoneOutput = customerData['phone']; // Extract phone number

        // Step 3: Create a Dedicated Virtual Account (DVA) for the new customer
        final dvaResponse = await createDVA(customerId, 'wema-bank');
        dvaId = dvaResponse['data']['id']; // Get the DVA ID from the response

        // Extract account details from the DVA response
        accountName = dvaResponse['data']['account_name']; // Account name
        accountNumber = dvaResponse['data']['account_number']; // Account number
        bankName = dvaResponse['data']['bank']
            ['name']; // Bank name (accessing nested map)
        createdAt = dvaResponse['data']['created_at']; // Created date
        updatedAt = dvaResponse['data']['updated_at']; // Updated date

        print(
            'Customer created and DVA created for new customer with DVA ID: $dvaId');
      }

      // Step 4: Save the DVA ID, customer ID, and customer details to Firestore
      try {
        await firestore.collection('PaystackUsers').doc(userId).set({
          'customerId': customerId,
          'dvaId': dvaId,
          'customerCode': customerCode, // Save customer code
          'firstName': firstNameOutput,
          'lastName': lastNameOutput,
          'email': emailOutput,
          'phone': phoneOutput, // Save phone number
          'accountName': accountName,
          'accountNumber': accountNumber,
          'bankName': bankName,
          'createdAt': createdAt,
          'updatedAt': updatedAt,
        }, SetOptions(merge: true));

        print(
            'About to save to Firestore: userId=$userId, customerId=$customerId, dvaId=$dvaId, customerCode=$customerCode, firstName=$firstNameOutput, lastName=$lastNameOutput, email=$emailOutput, phone=$phoneOutput, accountName=$accountName, accountNumber=$accountNumber, bankName=$bankName, createdAt=$createdAt, updatedAt=$updatedAt');
        print(
            'DVA ID, customer ID, and details saved to Firestore for user: $userId');
      } catch (e) {
        print('Error saving to Firestore: $e');
      }
    } catch (e) {
      print('Error handling customer and DVA: $e');
      throw e;
    }
  }

//   /// SignUp
  void signup() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', TImages.docerAnimation);

      // Check internet Connectivity
      final isConnected = await TNetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        // Remove loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you must have read and accept the Privacy Policy & Terms of Use.');
        // Remove loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await TAuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save Authenticated User data in the Firebase Firestore
      final newUser = TUserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNo.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(TUserRepository());
      await userRepository.saveUserRecord(newUser);

      // // Create Paystack customer
      // final customer = TCustomerModel(
      //   email: email.text.trim(),
      //   firstName: firstName.text.trim(),
      //   lastName: lastName.text.trim(),
      //   phone: phoneNo.text.trim(),
      // );

      // // Save Paystack customer data in Firestore
      // final customerRepository = Get.put(TUserRepository());
      // await customerRepository.savePaystackCustomerRecord(customer);

// Handle Paystack Customer and DVA
      // await handleCustomerAndDVA();

      // Assume you have the user's unique ID from Firestore or authentication
      // String userId = 'uniqueFirestoreUserId';
      String userId =
          userCredential.user!.uid; // Use a fallback if user is null

// Handle Paystack Customer and DVA
      await handleCustomerAndDVA(userId);

// Proceed with creating Paystack customer
      // await createPaystackCustomer(customer);

      // Remove loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue.');

      // Move to verify Email Screen
      // Get.to(() => TVerifyOTPScreen(
      //     //  email: email.text.trim(),
      //     ));
      Get.to(() => TVerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      // Remove loader
      TFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
