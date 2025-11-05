// features/authentication/screens/password_configuration/reset_password.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/reset_password.dart';


class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.token});

  final String token;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());
    final dark = THelperFunctions.isDarkMode(context);


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
              TTexts.changeYourPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              TTexts.changeYourPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections * 2),

            /// Password Input
            Obx(
                  () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: TTexts.newPassword,
                  labelStyle: TextStyle(
                    color: dark ? TColors.light : TColors.darkGrey,
                  ),
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                    !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Submit Button
            Obx(
                  () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : () => controller.resetPassword(token),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text(TTexts.done),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}