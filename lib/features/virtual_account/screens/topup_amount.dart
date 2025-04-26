import 'package:flutter/material.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

import 'bank_transfer_screen.dart';

class TopUpAmountScreen extends StatefulWidget {
  const TopUpAmountScreen({super.key});

  @override
  State<TopUpAmountScreen> createState() => _TopUpAmountScreenState();
}

class _TopUpAmountScreenState extends State<TopUpAmountScreen> {
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up with Card/Account'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount Section
              Text(
                'Amount',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  hintText: '\₦100.00 - 9,999.00',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: dark ? TColors.darkerGrey : TColors.white,
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null) {
                    return 'Please enter a valid number';
                  }
                  if (amount < 100 || amount > 9999) {
                    return 'Amount must be between \₦100 and \₦9,999';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Bank Transfer Notice
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BankTransferScreen()),
                  );
                },
                child: Text(
                  'For amount above \₦9,999.00, use bank transfer >',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: TColors.primary,
                    decoration: TextDecoration.underline,
                      fontFamily: 'Roboto'
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Next Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process the amount and proceed to payment
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Next'),
                ),
              ),

              const SizedBox(height: 40),
              // Regulatory Information
              Center(
                child: Text(
                  'Licensed by the CBN and insured by the NDIC',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: dark ? TColors.grey : TColors.darkGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}