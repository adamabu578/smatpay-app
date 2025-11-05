import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class SuccessPage extends StatelessWidget {
  final String message;
  final Map<String, dynamic>? transactionDetails;

  const SuccessPage({
    super.key,
    required this.message,
    this.transactionDetails,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Icon(
                Iconsax.tick_circle,
                size: 100,
                color: TColors.primary,
              ),
              const SizedBox(height: 20),
              Text(
                'Success!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Display transaction details if available
              if (transactionDetails != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  color: dark ? TColors.dark : TColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Reference', transactionDetails!['reference']),
                      _buildDetailRow('Recipient', transactionDetails!['recipient']),
                      _buildDetailRow('Name', transactionDetails!['name']),
                      if (transactionDetails!.containsKey('token'))
                        _buildDetailRow('Token', transactionDetails!['token']),
                      if (transactionDetails!.containsKey('units'))
                        _buildDetailRow('Units', transactionDetails!['units']),
                      _buildDetailRow('Amount', '₦${transactionDetails!['totalAmount']}'),
                      _buildDetailRow('Provider', transactionDetails!['provider']),
                      _buildDetailRow('Time', transactionDetails!['time']),
                    ],
                  ),
                ),

              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}