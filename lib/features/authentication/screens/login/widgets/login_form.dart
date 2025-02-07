import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/features/authentication/controllers/login/login_controller.dart';
import 'package:smatpay/features/authentication/screens/password_configuration/forgot_password.dart';
import 'package:smatpay/features/authentication/screens/signup/signup.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:smatpay/utils/validators/validation.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(TLoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.direct_right),
                  labelText: TTexts.email,
                  labelStyle: TextStyle(
                    color: dark ? TColors.light : TColors.primary2,
                  )),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            /// Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => TValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                    labelText: TTexts.password,
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
                    )),
              ),
            ),

            const SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),

            /// Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember Me
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value)),
                    Text(TTexts.rememberMe),
                  ],
                ),

                /// Forget Password
                TextButton(
                  onPressed: () => Get.to(() => const TForgetPassword()),
                  child: const Text(TTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  //   onPressed: () => Get.to(() => const TNavigationMenu()),
                  onPressed: () => controller.emailAndPasswordSignIn(),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(TSizes.md),
                      backgroundColor: TColors.primary,
                      side: const BorderSide(
                        color: TColors.primary,
                      )),
                  child: const Text(TTexts.signIn)),
            ),

            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            /// Create Account Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Get.to(() => const TSignupScreen()),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(TSizes.md),
                    backgroundColor: TColors.secondary2,
                    side: const BorderSide(
                      color: TColors.secondary2,
                    ),
                    foregroundColor: TColors
                        .primary, // Change this to your desired text color
                  ),
                  child: const Text(
                    TTexts.createAccount,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
