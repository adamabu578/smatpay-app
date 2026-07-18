import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
import 'package:smatpay/features/smatpay/brands/transaction/transaction_controller.dart';
import 'package:smatpay/features/smatpay/brands/transaction/transaction_model.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class FullTransactionScreen extends StatefulWidget {
  const FullTransactionScreen({super.key});

  @override
  State<FullTransactionScreen> createState() => _FullTransactionScreenState();
}

class _FullTransactionScreenState extends State<FullTransactionScreen> {
  final controller = TransactionController.instance;
  final _scrollController = ScrollController();
  final _searchQuery = ''.obs;
  final _selectedFilter = 'All'.obs;

  final filters = ['All', 'Airtime', 'Data', 'Electricity', 'TV', 'Other'];

  @override
  void initState() {
    super.initState();
    // Load more on scroll to bottom
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        controller.loadMoreTransactions();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<TransactionModel> get _filteredTransactions {
    var txns = controller.transactions.toList();

    // Apply category filter
    final filter = _selectedFilter.value;
    if (filter != 'All') {
      txns = txns.where((t) {
        final s = t.service.toLowerCase();
        switch (filter) {
          case 'Airtime':
            return s.contains('airtime');
          case 'Data':
            return s.contains('data');
          case 'Electricity':
            return s.contains('electric');
          case 'TV':
            return s.contains('tv') || s.contains('cable') || s.contains('gotv') || s.contains('dstv');
          case 'Other':
            return !s.contains('airtime') &&
                !s.contains('data') &&
                !s.contains('electric') &&
                !s.contains('tv') &&
                !s.contains('cable');
          default:
            return true;
        }
      }).toList();
    }

    // Apply search
    final query = _searchQuery.value.toLowerCase();
    if (query.isNotEmpty) {
      txns = txns.where((t) {
        return t.service.toLowerCase().contains(query) ||
            t.recipient.toLowerCase().contains(query) ||
            t.totalAmount.toString().contains(query);
      }).toList();
    }

    return txns;
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: AppBar(
        backgroundColor: dark ? TColors.secondary : TColors.softGrey,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left,
              color: dark ? TColors.white : TColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Transactions',
            style: TextStyle(color: dark ? TColors.white : TColors.black)),
      ),
      body: Column(
        children: [
          // --- Search + Summary ---
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: Column(
              children: [
                // Search bar
                TextField(
                  onChanged: (v) => _searchQuery.value = v,
                  decoration: InputDecoration(
                    hintText: 'Search transactions...',
                    prefixIcon:
                        const Icon(Iconsax.search_normal, color: TColors.primary, size: 20),
                    filled: true,
                    fillColor: dark ? TColors.primary2 : TColors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Spending summary
                Obx(() {
                  final txns = controller.transactions;
                  double total = 0;
                  for (final t in txns) {
                    total += t.totalAmount;
                  }
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: TColors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Iconsax.chart_2,
                              color: TColors.white, size: 20),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Spent',
                                style: TextStyle(
                                    color: TColors.white.withValues(alpha: 0.7),
                                    fontSize: 12)),
                            const SizedBox(height: 2),
                            Text(
                              '₦${_formatAmount(total)}',
                              style: const TextStyle(
                                color: TColors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${txns.length}',
                                style: const TextStyle(
                                    color: TColors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text('transactions',
                                style: TextStyle(
                                    color: TColors.white.withValues(alpha: 0.7),
                                    fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 14),

                // Filter chips
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return Obx(() {
                        final isSelected =
                            _selectedFilter.value == filters[index];
                        return GestureDetector(
                          onTap: () =>
                              _selectedFilter.value = filters[index],
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? TColors.primary
                                  : (dark ? TColors.primary2 : TColors.white),
                              borderRadius: BorderRadius.circular(20),
                              border: isSelected
                                  ? null
                                  : Border.all(
                                      color: dark
                                          ? TColors.darkGrey
                                          : TColors.grey),
                            ),
                            child: Text(
                              filters[index],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? TColors.white
                                    : (dark
                                        ? TColors.grey
                                        : TColors.darkerGrey),
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // --- Transaction List ---
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.transactions.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: List.generate(
                      6,
                      (_) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: TShimmerEffect(
                            width: double.infinity, height: 72, radius: 14),
                      ),
                    ),
                  ),
                );
              }

              if (controller.hasError.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.red, size: 48),
                      const SizedBox(height: 12),
                      Text('Failed to load transactions',
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: controller.fetchTransactions,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              final filtered = _filteredTransactions;

              if (filtered.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(TImages.notransaction,
                          width: 100, height: 100),
                      const SizedBox(height: 12),
                      Text(
                        _searchQuery.value.isNotEmpty ||
                                _selectedFilter.value != 'All'
                            ? 'No matching transactions'
                            : 'No transactions yet',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: dark ? TColors.grey : TColors.darkerGrey,
                            ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () =>
                    controller.fetchTransactions(forceRefresh: true),
                color: TColors.primary,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: filtered.length + 1, // +1 for load more indicator
                  itemBuilder: (context, index) {
                    if (index == filtered.length) {
                      // Load more indicator
                      return Obx(() {
                        if (controller.isLoading.value &&
                            controller.transactions.isNotEmpty) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                                child: CircularProgressIndicator(
                                    color: TColors.primary)),
                          );
                        }
                        if (controller.currentPage.value >=
                            controller.totalPages.value) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: Text(
                                "You've reached the end",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: dark
                                            ? TColors.darkGrey
                                            : TColors.darkGrey),
                              ),
                            ),
                          );
                        }
                        return const SizedBox(height: 20);
                      });
                    }

                    final txn = filtered[index];
                    return _TransactionTile(
                        transaction: txn, dark: dark, context: context);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  String _formatAmount(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
  }
}

// ─── Transaction Tile ────────────────────────────────────────────
class _TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final bool dark;
  final BuildContext context;

  const _TransactionTile({
    required this.transaction,
    required this.dark,
    required this.context,
  });

  IconData get _serviceIcon {
    final s = transaction.service.toLowerCase();
    if (s.contains('airtime')) return Iconsax.call;
    if (s.contains('data')) return Iconsax.wifi;
    if (s.contains('electric')) return Iconsax.flash_1;
    if (s.contains('tv') || s.contains('cable')) return Iconsax.monitor;
    return Iconsax.money_send;
  }

  @override
  Widget build(BuildContext outerContext) {
    final isSuccess = transaction.status == 'delivered';
    final statusColor = isSuccess ? Colors.green : Colors.orange;

    return GestureDetector(
      onTap: () => _showDetail(outerContext),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: dark ? TColors.primary2 : TColors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_serviceIcon, size: 20, color: statusColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.service,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    transaction.recipient.isNotEmpty
                        ? transaction.recipient
                        : transaction.createdAt,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: dark ? TColors.darkGrey : TColors.darkerGrey,
                          fontSize: 11,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '-₦${transaction.totalAmount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto',
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    transaction.statusDescription,
                    style: TextStyle(
                        fontSize: 10,
                        color: statusColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDetail(BuildContext ctx) {
    final dark = THelperFunctions.isDarkMode(ctx);
    final isSuccess = transaction.status == 'delivered';
    final statusColor = isSuccess ? Colors.green : Colors.orange;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: dark ? TColors.primary2 : TColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: dark ? TColors.darkGrey : TColors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            // Status icon
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSuccess ? Iconsax.tick_circle : Iconsax.clock,
                color: statusColor,
                size: 28,
              ),
            ),
            const SizedBox(height: 14),

            Text(
              transaction.statusDescription,
              style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            const SizedBox(height: 6),
            Text(
              '-₦${transaction.totalAmount.toStringAsFixed(2)}',
              style: Theme.of(ctx).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
            ),
            const SizedBox(height: 24),

            // Details
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: dark ? TColors.secondary : TColors.softGrey,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _detailRow(ctx, 'Service', transaction.service, dark),
                  _divider(dark),
                  _detailRow(ctx, 'Recipient', transaction.recipient, dark),
                  _divider(dark),
                  _detailRow(ctx, 'Unit Price',
                      '₦${transaction.unitPrice.toStringAsFixed(2)}', dark),
                  if (transaction.quantity > 1) ...[
                    _divider(dark),
                    _detailRow(
                        ctx, 'Quantity', '${transaction.quantity}', dark),
                  ],
                  if (transaction.discount > 0) ...[
                    _divider(dark),
                    _detailRow(ctx, 'Discount',
                        '-₦${transaction.discount.toStringAsFixed(2)}', dark),
                  ],
                  _divider(dark),
                  _detailRow(ctx, 'Total',
                      '₦${transaction.totalAmount.toStringAsFixed(2)}', dark),
                  _divider(dark),
                  _detailRow(ctx, 'Date', transaction.createdAt, dark),
                ],
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: TColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Close',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              ),
            ),
            SizedBox(height: MediaQuery.of(ctx).padding.bottom + 8),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _detailRow(
      BuildContext ctx, String label, String value, bool dark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                color: dark ? TColors.grey : TColors.darkerGrey)),
        Flexible(
          child: Text(value,
              style: Theme.of(ctx)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  Widget _divider(bool dark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child:
          Divider(height: 1, color: dark ? TColors.darkGrey : TColors.grey),
    );
  }
}
