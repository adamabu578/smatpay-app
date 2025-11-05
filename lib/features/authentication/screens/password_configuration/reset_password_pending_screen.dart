import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ResetPasswordPendingScreen extends StatelessWidget {
  const ResetPasswordPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Check Your Email',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'We\'ve sent a password reset link to your email. Please check your inbox and follow the instructions.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections * 2),
            Column(
              children: [
                const Icon(Iconsax.clock, size: 60),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                  'Password Reset Sent',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Text(
                  'After resetting your password, click below to continue',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: TSizes.spaceBtwSections * 2),
                // Simple button that navigates to login
                Column(
                  children: [
                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.offAllNamed('/login'),
                        child: const Text('Continue to Login'),
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    // Cancel Button
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () => Get.back(), // Just goes back
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}