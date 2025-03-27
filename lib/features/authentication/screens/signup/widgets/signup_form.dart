import 'package:smatpay/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

import '../../../controllers/signup/signup_controllerr.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          /// First and Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      TValidator.validateEmptyText('First Name', value),
                  expands: false,
                  decoration: InputDecoration(
                      labelText: TTexts.firstName,
                      labelStyle: TextStyle(
                        color: dark ? TColors.light : TColors.darkGrey,
                      ),
                      prefixIcon: const Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      TValidator.validateEmptyText('Last Name', value),
                  expands: false,
                  decoration: InputDecoration(
                      labelText: TTexts.lastName,
                      labelStyle: TextStyle(
                        color: dark ? TColors.light : TColors.darkGrey,
                      ),
                      prefixIcon: const Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          /// Email
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.direct),
              labelText: TTexts.email,
              labelStyle: TextStyle(
                color: dark ? TColors.light : TColors.darkGrey,
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          /// Phone No
          TextFormField(
            controller: controller.phoneNo,
            validator: (value) => TValidator.validatePhoneNumber(value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.call),
              labelText: TTexts.phoneNo,
              labelStyle: TextStyle(
                color: dark ? TColors.light : TColors.darkGrey,
              ),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

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
            height: TSizes.spaceBtwSections,
          ),

          /// Terms & Conditions Checkbox
          const TTermsAndConditionCheckbox(),

          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          ///Sign Up Button
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => ElevatedButton(
                  onPressed:
                      controller.isLoading.value ? null : controller.signup,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(TSizes.md),
                      backgroundColor: TColors.primary,
                      side: const BorderSide(
                        color: TColors.primary,
                      )),
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(
                          color: Colors.white) // ✅ Show loader
                      : Text(TTexts.createAccount)),
            ),
          ),
        ],
      ),
    );
  }
}
