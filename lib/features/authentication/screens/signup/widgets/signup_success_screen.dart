import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

import '../../login/login.dart';

class SignupSuccessScreen extends StatelessWidget {
  const SignupSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    // After 2 seconds, navigate to login screen
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => TLoginScreen());
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Icon with success animation
              const SizedBox(height: TSizes.appBarHeight * 2),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  children: [
                  // Animated checkmark
                  Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: TColors.primary.withOpacity(0.1),
                      ),
                      child: Icon(
                        Iconsax.tick_circle,
                        size: 100,
                        color: TColors.primary,
                      ),),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    // Title and Subtitle
                    Text(
                      TTexts.yourAccountCreatedTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Text(
                      TTexts.yourAccountCreatedSubTitle,
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    // Continue Button (optional - you can remove if you prefer auto-navigation only)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.offAll(() => TLoginScreen()),
                        child: const Text(TTexts.tContinue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}