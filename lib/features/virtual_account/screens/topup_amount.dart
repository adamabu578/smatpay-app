import 'package:flutter/material.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
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
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: TAppBar(
        title: const Text('Top Up with Card/Account'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Amount Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: dark ? TColors.primary2 : TColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Amount',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Min ₦100.00 — Max ₦9,999.00',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: dark ? TColors.grey : TColors.darkerGrey,
                          ),
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        hintText: '0.00',
                        prefixText: '₦ ',
                        prefixStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          color: dark ? TColors.white : TColors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: dark ? TColors.darkGrey : TColors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: dark ? TColors.darkGrey : TColors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: TColors.primary, width: 1.5),
                        ),
                        filled: true,
                        fillColor: dark ? TColors.secondary : TColors.softGrey,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: dark ? TColors.white : TColors.black,
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
                          return 'Amount must be between ₦100 and ₦9,999';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Bank Transfer Notice
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BankTransferScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: dark ? TColors.primary2 : TColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.account_balance, size: 20, color: TColors.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'For amount above ₦9,999.00, use bank transfer',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: TColors.primary,
                                fontFamily: 'Roboto',
                              ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 14, color: TColors.primary),
                    ],
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
