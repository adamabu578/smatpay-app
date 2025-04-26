import 'package:flutter/material.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TopUpWithCardAccountScreen extends StatefulWidget {
  const TopUpWithCardAccountScreen({super.key});

  @override
  State<TopUpWithCardAccountScreen> createState() => _TopUpWithCardAccountScreenState();
}

class _TopUpWithCardAccountScreenState extends State<TopUpWithCardAccountScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  String? selectedBank;
  String accountNumber = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up with Card/Account'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Bank Card'),
            Tab(text: 'Bank Account'),
          ],
          labelColor: TColors.primary,
          unselectedLabelColor: dark ? TColors.grey : TColors.darkGrey,
          indicatorColor: TColors.primary,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Bank Card Tab (Empty for now)
          const Center(
            child: Text('Bank Card functionality coming soon'),
          ),

          // Bank Account Tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To ensure the security of your funds, you can only add a bank account linked to your BYN(22164******)',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: dark ? TColors.grey : TColors.darkGrey,
                  ),
                ),
                const SizedBox(height: 30),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Bank Selection Dropdown
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Bank',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: dark ? TColors.darkerGrey : TColors.white,
                        ),
                        value: selectedBank,
                        items: const [
                          DropdownMenuItem(value: null, child: Text('Select Bank')),
                          DropdownMenuItem(value: 'Access Bank', child: Text('Access Bank')),
                          DropdownMenuItem(value: 'GTBank', child: Text('GTBank')),
                          DropdownMenuItem(value: 'Zenith Bank', child: Text('Zenith Bank')),
                          DropdownMenuItem(value: 'First Bank', child: Text('First Bank')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedBank = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a bank';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Account Number Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Bank Account',
                          hintText: 'Enter 10-digit account number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: dark ? TColors.darkerGrey : TColors.white,
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        onChanged: (value) {
                          setState(() {
                            accountNumber = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter account number';
                          }
                          if (value.length != 10) {
                            return 'Account number must be 10 digits';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Confirm Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Process the bank account top-up
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Confirm'),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
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
        ],
      ),
    );
  }
}