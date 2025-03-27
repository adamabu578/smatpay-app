import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/smatpay/brands/data/screen/payment_success.dart';
import 'package:smatpay/features/smatpay/brands/data/services/data_service.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TBuyDataScreen2 extends StatefulWidget {
  const TBuyDataScreen2({super.key});

  @override
  State<TBuyDataScreen2> createState() => _TBuyDataScreen2State();
}

class _TBuyDataScreen2State extends State<TBuyDataScreen2> {
  String? selectedDataPlan;
  String? selectedOperator;
  String? selectedAmount;
  String? phoneNumber;
  List<String> amountsList = [];
  TextEditingController amountController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  DataService dataService = DataService(); // Initialize the service

  String publicKey = 'pk_test_2190b0e1581eae836cfe33c6fa3bab35e92e49cf';
  final plugin = PaystackPlugin();
  String message = '';

  // final Map<String, List<String>> dataPlans = {
  //   // The same data plans map as before...
  // };

  // final Map<String, List<String>> amountLists = {
  //   // The same amount lists map as before...
  // };

  final Map<String, List<String>> dataPlans = {
    'MTN': [
      'MTN - DATA 500MB',
      'MTN - DATA 1GB',
      'MTN - DATA 2GB',
      'MTN - DATA 3GB',
      'MTN - DATA 5GB',
      'MTN - DATA 10GB',
    ],
    'Airtel': [
      'Airtel - DATA 500MB',
      'Airtel - DATA 1GB',
      'Airtel - DATA 2GB',
      'Airtel - DATA 3GB',
      'Airtel - DATA 5GB',
      'Airtel - DATA 10GB',
    ],
    'Glo': [
      'Glo - DATA 500MB',
      'Glo - DATA 1GB',
      'Glo - DATA 2GB',
      'Glo - DATA 3GB',
      'Glo - DATA 5GB',
      'Glo - DATA 10GB',
    ],
    '9mobile': [
      '9mobile - DATA 500MB',
      '9mobile - DATA 1GB',
      '9mobile - DATA 2GB',
      '9mobile - DATA 3GB',
      '9mobile - DATA 5GB',
      '9mobile - DATA 10GB',
    ],
  };

  final Map<String, List<String>> amountLists = {
    'MTN - DATA 500MB': ['N135'],
    'MTN - DATA 1GB': ['N265'],
    'MTN - DATA 2GB': ['N530'],
    'MTN - DATA 3GB': ['N795'],
    'MTN - DATA 5GB': ['N1325'],
    'MTN - DATA 10GB': ['N2650'],
    'Airtel - DATA 500MB': ['N150'],
    'Airtel - DATA 1GB': ['N300'],
    'Airtel - DATA 2GB': ['N600'],
    'Airtel - DATA 3GB': ['N900'],
    'Airtel - DATA 5GB': ['N1500'],
    'Airtel - DATA 10GB': ['N3000'],
    'Glo - DATA 500MB': ['N100'],
    'Glo - DATA 1GB': ['N200'],
    'Glo - DATA 2GB': ['N400'],
    'Glo - DATA 3GB': ['N600'],
    'Glo - DATA 5GB': ['N1000'],
    'Glo - DATA 10GB': ['N2000'],
    '9mobile - DATA 500MB': ['N120'],
    '9mobile - DATA 1GB': ['N240'],
    '9mobile - DATA 2GB': ['N480'],
    '9mobile - DATA 3GB': ['N720'],
    '9mobile - DATA 5GB': ['N1200'],
    '9mobile - DATA 10GB': ['N2400'],
  };

  @override
  void initState() {
    super.initState();
    amountController.text = selectedAmount ?? '';
    plugin.initialize(publicKey: publicKey);
  }

  @override
  void dispose() {
    amountController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> makePayment() async {
    int price = int.parse(amountController.text) * 100;
    Charge charge = Charge()
      ..amount = price
      ..reference = 'ref_${DateTime.now()}'
      ..currency = 'NGN';

    CheckoutResponse response = await plugin.checkout(context,
        method: CheckoutMethod.card, charge: charge);

    if (response.status == true) {
      message = 'Payment was successful. Ref: ${response.reference}';
      if (mounted) {}
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => TPaymentSuccessScreen(message: message),
          ),
          ModalRoute.withName('/'));
    }
  }

  Future<void> _purchaseData() async {
    if (selectedOperator == null ||
        selectedDataPlan == null ||
        selectedAmount == null ||
        phoneNumber == null ||
        phoneNumber!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields.')));
      return;
    }

    try {
      bool hasBalance = await dataService.checkAccountBalance();
      if (hasBalance) {
        final result = await dataService.purchaseData(selectedOperator!,
            selectedDataPlan!, selectedAmount!, phoneNumber!);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Data Purchase Successful: ${result['message']}')));
        await makePayment(); // Proceed with payment after successful data purchase
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Insufficient balance.')));
      }
    } catch (e) {
      // Improved error handling
      String errorMessage;
      if (e is http.ClientException) {
        errorMessage = 'Network error. Please try again later.';
      } else {
        errorMessage = 'Error: $e';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  final String _paystackSecretKey =
      'sk_test_755ce9477ba4f1f8c8382b7cc02296765d0a48df';

  Future<int> checkBalance() async {
    final url = "https://api.paystack.co/balance";
    final authorization =
        "Authorization: Bearer $_paystackSecretKey"; // Use your secret key

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': authorization,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Extract the balance amount (adjust according to your API response structure)
      return data['data']
          ['balance']; // Assuming balance is in 'data' -> 'balance'
    } else {
      throw Exception('Failed to fetch balance');
    }
  }

  Future<void> proceedToPayment() async {
    final balance = await checkBalance();
    final selectedAmountValue = int.parse(amountController.text);

    if (balance < selectedAmountValue) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Insufficient balance for this transaction.')),
      );
      return;
    }

    await _purchaseData();

    // If _purchaseData is successful, proceed to make the payment
    await makePayment();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    List<String> filteredDataPlans =
        selectedOperator != null ? dataPlans[selectedOperator]! : [];

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Buy Data'),
        showBackArrow: true,
        actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Container(
                width: double.infinity,
                height: 420,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: TColors.grey, width: 1),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Select Operator, Plan, and Amount Fields
                      // Already defined in your code...
                      Text(
                        'Select Mobile Operator',
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: dark ? TColors.white : TColors.black,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOperator =
                                    'Airtel'; // Changes the selected operator to 'Airtel'
                                selectedDataPlan =
                                    null; // Resets the selected data plan to null
                                selectedAmount =
                                    null; // Resets the selected amount to null
                                amountsList = amountLists[
                                    'Airtel - DATA 500MB']!; // Sets amountsList to the list of amounts for 'Airtel - DATA 500MB'
                                amountController.text = selectedAmount ??
                                    ''; // Updates the amountController's text to the selected amount or empty string
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedOperator == 'Airtel'
                                      ? TColors.primary
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                TImages.airtel,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOperator = 'Glo';
                                selectedDataPlan = null;
                                selectedAmount = null;
                                amountsList = amountLists['Glo - DATA 500MB']!;
                                amountController.text = selectedAmount ?? '';
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedOperator == 'Glo'
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                TImages.glo,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOperator = 'MTN';
                                selectedDataPlan = null;
                                selectedAmount = null;
                                amountsList = amountLists['MTN - DATA 500MB']!;
                                amountController.text = selectedAmount ?? '';
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedOperator == 'MTN'
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                TImages.mtn,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOperator = '9mobile';
                                selectedDataPlan = null;
                                selectedAmount = null;
                                amountsList =
                                    amountLists['9mobile - DATA 500MB']!;
                                amountController.text = selectedAmount ?? '';
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedOperator == '9mobile'
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                TImages.ninemobile,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      Text(
                        'Select Plan',
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: dark ? TColors.white : TColors.black,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        hint: const Text('Select Plan'),
                        value: selectedDataPlan,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDataPlan = newValue;
                            selectedAmount = amountLists[newValue!]![
                                0]; // Set first amount by default
                            amountsList = amountLists[newValue]!;
                            amountController.text = selectedAmount ?? '';
                          });
                        },
                        items: filteredDataPlans.map((String dataPlan) {
                          return DropdownMenuItem<String>(
                            value: dataPlan,
                            child: Text(
                              dataPlan,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      TextFormField(
                        controller: amountController,
                        enabled: false,
                        style: TextStyle(
                          // Style for selected amount text
                          fontSize: 16, // Increase font size
                          color: dark
                              ? TColors.light
                              : TColors.black, // Set text color
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.money),
                          labelText: 'Selected Amount',
                          labelStyle: TextStyle(
                            color: dark ? TColors.light : TColors.black,
                          ),
                          prefixIconColor: TColors.primary,
                        ),
                      ),

                      const SizedBox(height: 10),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.call),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: dark ? TColors.light : TColors.black,
                          ),
                          prefixIconColor: TColors.primary,
                        ),
                        onChanged: (value) => phoneNumber = value,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: proceedToPayment,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(TSizes.md),
                    backgroundColor: TColors.primary,
                    side: const BorderSide(color: TColors.primary),
                  ),
                  child: const Text('Proceed to payment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
