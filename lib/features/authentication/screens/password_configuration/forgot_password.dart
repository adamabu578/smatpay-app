// features/authentication/screens/password_configuration/forgot_password.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/forget_password/forget_password_controller.dart';
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final controller = Get.put(ForgotPasswordController());

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.lightGrey,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              TTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              TTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections * 2),

            /// Text field
            Form(
              key: controller.forgotPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                decoration: InputDecoration(
                  labelText: TTexts.email,
                  labelStyle: TextStyle(
                    color: dark ? TColors.light : TColors.darkGrey,
                  ),
                  prefixIcon: const Icon(Iconsax.direct_right),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Submit Button
            Obx(
                  () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : () => controller.sendPasswordResetEmail(),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text(TTexts.submit),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}