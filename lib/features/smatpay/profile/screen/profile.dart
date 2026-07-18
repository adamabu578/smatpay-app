import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/common/widgets/images/t_circular_image.dart';
import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
import 'package:smatpay/features/personalization/controllers/user_controller.dart';
import 'package:smatpay/features/smatpay/profile/screen/help_support.dart';
import 'package:smatpay/features/smatpay/profile/screen/personalinformation.dart';
import 'package:smatpay/features/smatpay/profile/screen/privacy_security.dart';
import 'package:smatpay/features/smatpay/profile/screen/refer_earn.dart';
import 'package:smatpay/features/smatpay/profile/screen/settings.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

import '../../../authentication/controllers/login/login_controller.dart';
import '../../../authentication/controllers/profile/profile_controller.dart';

class TProfileScreensmatpay extends StatelessWidget {
  const TProfileScreensmatpay({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TUserController.instance;
    Get.put(TLoginController());
    final profileController = Get.find<ProfileController>();
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Profile Header ---
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: dark ? TColors.primary2 : TColors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                  child: Column(
                    children: [
                      // Top row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Profile',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () => Get.to(() => TSettingsScreen()),
                            child: Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                color: dark
                                    ? TColors.primary.withValues(alpha: 0.15)
                                    : TColors.secondary2,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Iconsax.setting_2,
                                  size: 20,
                                  color:
                                      dark ? TColors.white : TColors.primary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Avatar
                      Obx(() {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : TImages.smatpayuser;
                        return controller.imageUploading.value
                            ? const TShimmerEffect(
                                width: 90, height: 90, radius: 90)
                            : Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: TColors.primary, width: 2),
                                ),
                                child: TCircularImage(
                                  image: image,
                                  width: 90,
                                  height: 90,
                                  isNetworkImage: networkImage.isNotEmpty,
                                ),
                              );
                      }),
                      const SizedBox(height: 14),

                      // Name & email
                      Obx(() {
                        if (profileController.isLoading.value) {
                          return Column(
                            children: const [
                              TShimmerEffect(width: 120, height: 18),
                              SizedBox(height: 6),
                              TShimmerEffect(width: 160, height: 14),
                            ],
                          );
                        }
                        if (profileController.fullName.value.isEmpty) {
                          return GestureDetector(
                            onTap: () => profileController.loadUserProfile(),
                            child: Text(
                              'Tap to refresh profile',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: TColors.primary),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            Text(
                              profileController.fullName.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              profileController.email.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: TColors.primary),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- Menu Items ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: dark ? TColors.primary2 : TColors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    _ProfileMenuItem(
                      icon: Iconsax.user,
                      title: 'Personal Information',
                      subtitle: 'View and edit your details',
                      dark: dark,
                      onTap: () =>
                          Get.to(() => const TPersonalInformationScreen()),
                    ),
                    _MenuDivider(dark: dark),
                    _ProfileMenuItem(
                      icon: Iconsax.gift,
                      title: 'Refer and Earn',
                      subtitle: 'Referrals & commissions',
                      dark: dark,
                      onTap: () =>
                          Get.to(() => const TReferAndEarnScreen()),
                    ),
                    _MenuDivider(dark: dark),
                    _ProfileMenuItem(
                      icon: Iconsax.headphone,
                      title: 'Help & Support',
                      subtitle: 'Get help from our team',
                      dark: dark,
                      onTap: () =>
                          Get.to(() => const THelpAndSupportScreen()),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: dark ? TColors.primary2 : TColors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    _ProfileMenuItem(
                      icon: Iconsax.shield_tick,
                      title: 'Privacy & Security',
                      subtitle: 'Manage your security settings',
                      dark: dark,
                      onTap: () =>
                          Get.to(() => const TPrivacyAndSecurityScreen()),
                    ),
                    _MenuDivider(dark: dark),
                    _ProfileMenuItem(
                      icon: Iconsax.star_1,
                      title: 'Rate Us',
                      subtitle: 'Love SmatPay? Leave a review',
                      dark: dark,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // --- Logout Button ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                final isLoading = TLoginController.instance.isLoading.value;
                return GestureDetector(
                  onTap: isLoading
                      ? null
                      : () => TLoginController.instance
                          .logoutAccountWarningPopup(),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: TColors.error.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: TColors.error.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isLoading)
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: TColors.error,
                            ),
                          )
                        else
                          Icon(Iconsax.logout, color: TColors.error, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          isLoading ? 'Logging out...' : 'Log Out',
                          style: TextStyle(
                            color: TColors.error,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 16),

            // App version
            Text(
              'SmatPay v1.0.0',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: dark ? TColors.darkGrey : TColors.darkGrey,
                    fontSize: 11,
                  ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// ─── Profile Menu Item ───────────────────────────────────────────
class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool dark;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.dark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: dark
                    ? TColors.primary.withValues(alpha: 0.12)
                    : TColors.secondary2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 20, color: TColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: dark ? TColors.darkGrey : TColors.darkerGrey,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
            Icon(Iconsax.arrow_right_3,
                size: 18, color: dark ? TColors.darkGrey : TColors.darkGrey),
          ],
        ),
      ),
    );
  }
}

// ─── Menu Divider ────────────────────────────────────────────────
class _MenuDivider extends StatelessWidget {
  final bool dark;
  const _MenuDivider({required this.dark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        color: dark ? TColors.secondary : TColors.softGrey,
      ),
    );
  }
}
