import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/features/smatpay/brands/Alpha/screens/alpha_topup.dart';
import 'package:smatpay/features/smatpay/brands/airtime/screen/buyairtime.dart';
import 'package:smatpay/features/smatpay/brands/cableTv/cabletv.dart';
import 'package:smatpay/features/smatpay/brands/data_sme/screen/testing_sme.dart';
import 'package:smatpay/features/smatpay/brands/education/education.dart';
import 'package:smatpay/features/smatpay/brands/electricity/electricity.dart';
import 'package:smatpay/features/smatpay/brands/gift/gift.dart';
import 'package:smatpay/features/smatpay/brands/smile/smile_buy.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TServicesScreen extends StatelessWidget {
  const TServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // --- Header ---
                Text(
                  'Services',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Pay bills and manage subscriptions easily',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: dark ? TColors.grey : TColors.darkerGrey,
                      ),
                ),

                const SizedBox(height: 28),

                // --- Telecom Section ---
                _SectionLabel(title: 'Telecom', dark: dark),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _ServiceCard(
                        icon: Iconsax.call,
                        label: 'Airtime',
                        subtitle: 'All networks',
                        dark: dark,
                        onTap: () => Get.to(() => const TBuyAirtimeScreen()),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ServiceCard(
                        icon: Iconsax.wifi,
                        label: 'Data',
                        subtitle: 'SME & Gifting',
                        dark: dark,
                        onTap: () => Get.to(() => TTestingSmeDataScreen()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _ServiceCard(
                        image: TImages.alphacaller,
                        label: 'Alpha Caller',
                        subtitle: 'Voice bundles',
                        dark: dark,
                        onTap: () =>
                            Get.to(() => const TAlphaTopUpDataScreen()),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ServiceCard(
                        image: TImages.smilevoice,
                        label: 'Smile',
                        subtitle: 'Voice & Data',
                        dark: dark,
                        onTap: () => Get.to(() => const TSmileBuyScreen()),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // --- Bills Section ---
                _SectionLabel(title: 'Bills & Utilities', dark: dark),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _ServiceCard(
                        icon: Iconsax.flash_1,
                        label: 'Electricity',
                        subtitle: 'Prepaid & Postpaid',
                        dark: dark,
                        onTap: () =>
                            Get.to(() => const ElectricityPurchaseScreen()),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ServiceCard(
                        icon: Iconsax.monitor,
                        label: 'Cable TV',
                        subtitle: 'DStv, GOtv, Startimes',
                        dark: dark,
                        onTap: () => Get.to(() => TCableTvScreen()),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // --- More Section ---
                _SectionLabel(title: 'More Services', dark: dark),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _ServiceCard(
                        icon: Iconsax.gift,
                        label: 'Gift Cards',
                        subtitle: 'Send & redeem',
                        dark: dark,
                        onTap: () => Get.to(() => const TGiftScreen()),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ServiceCard(
                        icon: Iconsax.teacher,
                        label: 'Education',
                        subtitle: 'WAEC, JAMB & more',
                        dark: dark,
                        onTap: () => Get.to(() => const TEducationScreen()),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // --- Promo Banner ---
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Refer & Earn',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: TColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Invite friends to SmatPay and earn rewards on every transaction they make.',
                              style: TextStyle(
                                color: TColors.white.withValues(alpha: 0.8),
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: TColors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Invite Now',
                                style: TextStyle(
                                  color: TColors.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Image.asset(
                        TImages.referalgift,
                        width: 70,
                        height: 70,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Section Label ───────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String title;
  final bool dark;
  const _SectionLabel({required this.title, required this.dark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 18,
          decoration: BoxDecoration(
            color: TColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: dark ? TColors.grey : TColors.darkerGrey,
              ),
        ),
      ],
    );
  }
}

// ─── Service Card ────────────────────────────────────────────────
class _ServiceCard extends StatelessWidget {
  final IconData? icon;
  final String? image;
  final String label;
  final String subtitle;
  final bool dark;
  final VoidCallback onTap;

  const _ServiceCard({
    this.icon,
    this.image,
    required this.label,
    required this.subtitle,
    required this.dark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: dark ? TColors.primary2 : TColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: dark
                    ? TColors.primary.withValues(alpha: 0.15)
                    : TColors.secondary2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: image != null
                    ? Image.asset(image!, width: 24, height: 24)
                    : Icon(icon, size: 22, color: TColors.primary),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: dark ? TColors.darkGrey : TColors.darkerGrey,
                    fontSize: 11,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
