import 'package:flutter/material.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class BankTransferScreen extends StatelessWidget {
  const BankTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Transfer'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Details Section
            _buildDetailRow(context, 'SmatPay Account Number', '903 398 7126'),
            _buildDetailRow(context, 'Bank', 'SmatPay Digital Service Limited (OPay)'),
            _buildDetailRow(context, 'Name', 'OLUMIDE LAJU ANDRE'),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Copy account number
                    },
                    child: const Text('Copy Number'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Share details
                    },
                    child: const Text('Share Details'),
                  ),
                ),
              ],
            ),

            const Divider(height: 40),

            // Instructions Section
            Text(
              'Add money via bank transfer in just 3 steps',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            _buildNumberedStep(context, '1. Copy the account details above-903 398 7126 is your OPay Account Number'),
            _buildNumberedStep(context, '2. Open the bank app you want to transfer money from'),
            _buildNumberedStep(context, '3. Transfer the details amount to your OPay Account'),

            const Divider(height: 40),

            // Bank Apps Section
            Text(
              'Click on any of the bank icons below to be taken directly to the bank\'s app.',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Bank Icons Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              children: const [
                _BankIcon(name: 'Access Bank'),
                _BankIcon(name: 'First Bank Of Nigeria'),
                _BankIcon(name: 'United Bank For Africa'),
                _BankIcon(name: 'Guaranty Trust Bank'),
                _BankIcon(name: 'Zenith Bank'),
                _BankIcon(name: 'Kuda MFB'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedStep(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _BankIcon extends StatelessWidget {
  final String name;

  const _BankIcon({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              name.substring(0, 1),
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}