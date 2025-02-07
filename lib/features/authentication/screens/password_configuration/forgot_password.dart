import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:smatpay/utils/validators/validation.dart';

class TForgetPassword extends StatelessWidget {
  const TForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(TForgetPasswordController());
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.lightGrey,
      appBar: const TAppBar(
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Heading
            Text(
              TTexts.forgetPassword,
              style: Theme.of(context).textTheme.headlineMedium!.apply(
                    color: dark ? TColors.primary : TColors.primary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              TTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium!.apply(
                    color: dark ? TColors.white : TColors.primary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections * 2,
            ),

            ///Text Field
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validateEmail,
                decoration: InputDecoration(
                  labelText: TTexts.email,
                  prefixIcon: const Icon(
                    Iconsax.direct_right,
                  ),
                  labelStyle: TextStyle(
                    color: dark ? TColors.light : TColors.dark,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections * 2,
            ),

            ///Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  // onPressed: () {},
                  onPressed: () => controller.sendPasswordResetEmail(),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(TSizes.md),
                      backgroundColor: TColors.primary,
                      side: const BorderSide(
                        color: TColors.primary,
                      )),
                  child: const Text(TTexts.submit)),
            )
          ],
        ),
      ),
    );
  }
}
