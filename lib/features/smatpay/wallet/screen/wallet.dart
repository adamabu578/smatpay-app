import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
import 'package:smatpay/features/smatpay/profile/screen/notifications.dart';
import 'package:smatpay/features/virtual_account/screens/account_screen.dart';
import 'package:smatpay/features/virtual_account/screens/wallet_balance_screen.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

import '../../brands/transaction/transaction_controller.dart';
import '../../brands/transaction/transaction_model.dart';
import '../../brands/transaction/transaction_screen.dart';
import '../../controllers/wallet_controller.dart';

class TWalletScreen extends StatelessWidget {
  const TWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final walletController = Get.put(WalletController());
    final transactionController = Get.put(TransactionController());

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            walletController.fetchWalletBalance(),
            transactionController.fetchTransactions(forceRefresh: true),
          ]);
        },
        color: TColors.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Purple Header Area ---
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: TColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Wallet',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: TColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Get.to(() => const TNotificationScreen()),
                              child: Container(
                                height: 38,
                                width: 38,
                                decoration: BoxDecoration(
                                  color: TColors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Iconsax.notification,
                                    size: 20, color: TColors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),

                        // Balance label
                        Row(
                          children: [
                            Text(
                              'Total Balance',
                              style: TextStyle(
                                color: TColors.white.withValues(alpha: 0.7),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Obx(() => GestureDetector(
                                  onTap:
                                      walletController.toggleBalanceVisibility,
                                  child: Icon(
                                    walletController.showBalance.value
                                        ? Iconsax.eye
                                        : Iconsax.eye_slash,
                                    color:
                                        TColors.white.withValues(alpha: 0.7),
                                    size: 18,
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // Balance amount
                        Obx(() {
                          if (walletController.isLoading.value) {
                            return const TShimmerEffect(
                                width: 150, height: 36);
                          }
                          return Text(
                            walletController.showBalance.value
                                ? '₦${walletController.balance.value.toStringAsFixed(2)}'
                                : '₦ ••••••',
                            style: const TextStyle(
                              color: TColors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            ),
                          );
                        }),

                        const SizedBox(height: 24),

                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: _HeaderButton(
                                icon: Iconsax.add,
                                label: 'Fund',
                                onTap: () =>
                                    Get.to(() => TAccountScreen()),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _HeaderButton(
                                icon: Iconsax.arrow_up_1,
                                label: 'Withdraw',
                                onTap: () =>
                                    Get.to(() => TWalletBalanceScreen()),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _HeaderButton(
                                icon: Iconsax.receipt_1,
                                label: 'History',
                                onTap: () => Get.to(
                                    () => const FullTransactionScreen()),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // --- Spending Insights Card ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: dark ? TColors.primary2 : TColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Iconsax.chart_2,
                              size: 20, color: TColors.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Spending Overview',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      // Mini bar chart
                      Obx(() {
                        final txns = transactionController.transactions;
                        if (txns.isEmpty) {
                          return _EmptyInsight(dark: dark);
                        }
                        return _SpendingBars(transactions: txns, dark: dark);
                      }),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- Saved Beneficiaries ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: dark ? TColors.primary2 : TColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Iconsax.people,
                              size: 20, color: TColors.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Quick Send',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          // Add new
                          _BeneficiaryAvatar(
                            icon: Iconsax.add,
                            label: 'Add',
                            dark: dark,
                            isPrimary: true,
                          ),
                          const SizedBox(width: 16),
                          _BeneficiaryAvatar(
                            letter: 'A',
                            label: 'Airtime',
                            dark: dark,
                          ),
                          const SizedBox(width: 16),
                          _BeneficiaryAvatar(
                            letter: 'D',
                            label: 'Data',
                            dark: dark,
                          ),
                          const SizedBox(width: 16),
                          _BeneficiaryAvatar(
                            letter: 'E',
                            label: 'Electric',
                            dark: dark,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- Recent Activity ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Activity',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Get.to(() => const FullTransactionScreen()),
                      child: Text(
                        'See All',
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: TColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() {
                  final controller = TransactionController.instance;

                  if (controller.isLoading.value) {
                    return Column(
                      children: List.generate(
                        3,
                        (_) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TShimmerEffect(
                            width: double.infinity,
                            height: 64,
                            radius: 14,
                          ),
                        ),
                      ),
                    );
                  }

                  if (controller.transactions.isEmpty) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 36),
                      decoration: BoxDecoration(
                        color: dark ? TColors.primary2 : TColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Image.asset(TImages.notransaction,
                              width: 80, height: 80),
                          const SizedBox(height: 10),
                          Text(
                            'No activity yet',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: dark
                                      ? TColors.grey
                                      : TColors.darkerGrey,
                                ),
                          ),
                        ],
                      ),
                    );
                  }

                  final recent = controller.transactions.take(5).toList();
                  return Column(
                    children: recent
                        .map((txn) => _ActivityTile(
                            transaction: txn, dark: dark, context: context))
                        .toList(),
                  );
                }),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Header Button ───────────────────────────────────────────────
class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HeaderButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: TColors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, color: TColors.white, size: 22),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                color: TColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Beneficiary Avatar ──────────────────────────────────────────
class _BeneficiaryAvatar extends StatelessWidget {
  final IconData? icon;
  final String? letter;
  final String label;
  final bool dark;
  final bool isPrimary;

  const _BeneficiaryAvatar({
    this.icon,
    this.letter,
    required this.label,
    required this.dark,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isPrimary
                ? TColors.primary.withValues(alpha: 0.15)
                : (dark ? TColors.secondary : TColors.softGrey),
            borderRadius: BorderRadius.circular(16),
            border: isPrimary
                ? Border.all(
                    color: TColors.primary.withValues(alpha: 0.3), width: 1.5)
                : null,
          ),
          child: Center(
            child: icon != null
                ? Icon(icon, size: 22, color: TColors.primary)
                : Text(
                    letter ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: TColors.primary,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}

// ─── Spending Bars ───────────────────────────────────────────────
class _SpendingBars extends StatelessWidget {
  final List<TransactionModel> transactions;
  final bool dark;

  const _SpendingBars({required this.transactions, required this.dark});

  @override
  Widget build(BuildContext context) {
    // Group last 7 days of spending
    final now = DateTime.now();
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final dayLabels = List.generate(7, (i) {
      final d = now.subtract(Duration(days: 6 - i));
      return days[d.weekday - 1];
    });

    // Calculate amounts per day (simplified)
    final amounts = List.generate(7, (i) {
      final d = now.subtract(Duration(days: 6 - i));
      double total = 0;
      for (final txn in transactions) {
        try {
          // Simple date comparison
          if (txn.createdAt.contains(
              '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}')) {
            total += txn.totalAmount;
          }
        } catch (_) {}
      }
      return total;
    });

    final maxAmount = amounts.reduce((a, b) => a > b ? a : b);
    final maxHeight = maxAmount > 0 ? maxAmount : 1.0;

    return SizedBox(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(7, (i) {
          final ratio = amounts[i] / maxHeight;
          final barHeight = (ratio * 60).clamp(4.0, 60.0);
          final isToday = i == 6;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (amounts[i] > 0)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '₦${_shortAmount(amounts[i])}',
                        style: TextStyle(
                          fontSize: 8,
                          fontFamily: 'Roboto',
                          color: isToday
                              ? TColors.primary
                              : (dark ? TColors.grey : TColors.darkerGrey),
                        ),
                      ),
                    ),
                  Container(
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: isToday
                          ? TColors.primary
                          : TColors.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    dayLabels[i],
                    style: TextStyle(
                      fontSize: 10,
                      color: isToday
                          ? TColors.primary
                          : (dark ? TColors.darkGrey : TColors.darkerGrey),
                      fontWeight:
                          isToday ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  String _shortAmount(double amount) {
    if (amount >= 1000) return '${(amount / 1000).toStringAsFixed(1)}k';
    return amount.toStringAsFixed(0);
  }
}

// ─── Empty Insight ───────────────────────────────────────────────
class _EmptyInsight extends StatelessWidget {
  final bool dark;
  const _EmptyInsight({required this.dark});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.chart_1,
                size: 28,
                color: dark ? TColors.darkGrey : TColors.grey),
            const SizedBox(height: 6),
            Text(
              'Spending data will appear here',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: dark ? TColors.darkGrey : TColors.darkGrey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Activity Tile ───────────────────────────────────────────────
class _ActivityTile extends StatelessWidget {
  final TransactionModel transaction;
  final bool dark;
  final BuildContext context;

  const _ActivityTile({
    required this.transaction,
    required this.dark,
    required this.context,
  });

  @override
  Widget build(BuildContext outerContext) {
    final isSuccess = transaction.status == 'delivered';
    final statusColor = isSuccess ? Colors.green : Colors.orange;

    // Pick icon based on service type
    IconData serviceIcon = Iconsax.money_send;
    if (transaction.service.toLowerCase().contains('airtime')) {
      serviceIcon = Iconsax.call;
    } else if (transaction.service.toLowerCase().contains('data')) {
      serviceIcon = Iconsax.wifi;
    } else if (transaction.service.toLowerCase().contains('electric')) {
      serviceIcon = Iconsax.flash_1;
    } else if (transaction.service.toLowerCase().contains('tv') ||
        transaction.service.toLowerCase().contains('cable')) {
      serviceIcon = Iconsax.monitor;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: dark ? TColors.primary2 : TColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(serviceIcon, size: 20, color: statusColor),
          ),
          const SizedBox(width: 14),

          // Details
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
                const SizedBox(height: 2),
                Text(
                  transaction.createdAt,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: dark ? TColors.darkGrey : TColors.darkerGrey,
                        fontSize: 11,
                      ),
                ),
              ],
            ),
          ),

          // Amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '-₦${transaction.totalAmount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: dark ? TColors.white : TColors.black,
                ),
              ),
              const SizedBox(height: 2),
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
