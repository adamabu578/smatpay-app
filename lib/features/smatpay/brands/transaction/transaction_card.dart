import 'package:flutter/material.dart';
import 'package:smatpay/features/smatpay/brands/transaction/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  final bool showFullDetails; // Changed from isCompact to showFullDetails for clarity

  const TransactionCard({
    super.key,
    required this.transaction,
    this.showFullDetails = false, // Default to false for compact view
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction.service,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '₦${transaction.totalAmount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: dark ? Colors.greenAccent : Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (showFullDetails) ...[
              Text(
                'To: ${transaction.recipient}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
            ],
            Text(
              transaction.createdAt,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
            if (showFullDetails) const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: transaction.status == 'delivered'
                        ? Colors.green.withOpacity(0.2)
                        : Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    transaction.statusDescription,
                    style: TextStyle(
                      color: transaction.status == 'delivered'
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}