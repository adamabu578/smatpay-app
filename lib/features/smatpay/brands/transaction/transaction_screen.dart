import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/smatpay/brands/transaction/transaction_card.dart';
import 'package:smatpay/features/smatpay/brands/transaction/transaction_controller.dart';


class FullTransactionScreen extends StatelessWidget {
  const FullTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TransactionController.instance;

    return Scaffold(
      appBar: TAppBar(
        title: const Text('Transaction History'),
        showBackArrow: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 50),
                const SizedBox(height: 16),
                Text('Failed to load transactions',
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchTransactions,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.transactions.isEmpty) {
          return const Center(
            child: Text('No transactions found'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final transaction = controller.transactions[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TransactionCard(transaction: transaction),
            );
          },
        );
      }),
    );
  }
}