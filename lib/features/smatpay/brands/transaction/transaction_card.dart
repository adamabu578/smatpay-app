import 'package:flutter/material.dart';
import 'package:smatpay/features/smatpay/brands/transaction/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  final bool showFullDetails;

  const TransactionCard({
    super.key,
    required this.transaction,
    this.showFullDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final statusColor = transaction.status == 'delivered'
        ? Colors.green
        : Colors.orange;

    return Card(
      elevation: 0, // More modern flat look
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with service and amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    transaction.service,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '₦${transaction.totalAmount.toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.greenAccent : const Color(0xFF00A86B),
                    fontFamily: 'RobotoMono', // Monospace for better amount alignment
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Recipient details (if expanded)
            if (showFullDetails) ...[
              _buildDetailRow(
                context,
                icon: Icons.person_outline,
                text: transaction.recipient,
              ),
              const SizedBox(height: 8),
            ],

            // Date row
            _buildDetailRow(
              context,
              icon: Icons.access_time_outlined,
              text: transaction.createdAt,
              secondary: true,
            ),
            const SizedBox(height: 12),

            // Status chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: statusColor.withOpacity(0.5),
                  width: 0.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    transaction.status == 'delivered'
                        ? Icons.check_circle_outline
                        : Icons.pending_outlined,
                    size: 16,
                    color: statusColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    transaction.statusDescription,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      BuildContext context, {
        required IconData icon,
        required String text,
        bool secondary = false,
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: secondary
              ? isDark ? Colors.grey[400] : Colors.grey[600]
              : isDark ? Colors.grey[300] : Colors.grey[800],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: secondary
                  ? isDark ? Colors.grey[400] : Colors.grey[600]
                  : isDark ? Colors.grey[300] : Colors.grey[800],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}