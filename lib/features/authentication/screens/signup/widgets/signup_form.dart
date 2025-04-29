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
            height: TSizes.spaceBtwSections,
          ),

          /// NUBAN Assignment Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Title
              Text(
                'Bank Account Setup',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: dark ? TColors.light : TColors.dark,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // NUBAN Toggle
              Container(
                decoration: BoxDecoration(
                  color: dark ? TColors.dark.withOpacity(0.4) : TColors.light.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.md,
                  vertical: TSizes.sm,
                ),
                child: Row(
                  children: [
                    Obx(() => Checkbox(
                      value: controller.assignNuban.value,
                      onChanged: (value) => controller.assignNuban.value = value!,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Expanded(
                      child: Text(
                        'Create virtual account (NUBAN)',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: dark ? TColors.light : TColors.dark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// BVN Information (shown only when assignNuban is true)
              Obx(() => Visibility(
                visible: controller.assignNuban.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bank Verification Details',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: dark ? TColors.light : TColors.dark,
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    TextFormField(
                      controller: controller.bvn,
                      validator: (value) => controller.assignNuban.value
                          ? TValidator.validateEmptyText('BVN', value)
                          : null,
                      decoration: InputDecoration(
                        labelText: 'BVN',
                        hintText: 'Enter your 11-digit BVN',
                        labelStyle: TextStyle(
                          color: dark ? TColors.light : TColors.darkGrey,
                        ),
                        prefixIcon: const Icon(Iconsax.card),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: controller.accountNumber,
                      validator: (value) => controller.assignNuban.value
                          ? TValidator.validateEmptyText('Account Number', value)
                          : null,
                      decoration: InputDecoration(
                        labelText: 'Account Number',
                        hintText: 'Your existing account number',
                        labelStyle: TextStyle(
                          color: dark ? TColors.light : TColors.darkGrey,
                        ),
                        prefixIcon: const Icon(Iconsax.card),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),

// Replace the TextFormField for bank code with this:
                    Obx(() {
                      if (controller.isLoadingBanks.value) {
                        return const CircularProgressIndicator();
                      }

                      return DropdownButtonFormField<String>(
                        value: controller.selectedBank.value.isEmpty ? null : controller.selectedBank.value,
                        decoration: InputDecoration(
                          labelText: 'Bank',
                          labelStyle: TextStyle(
                            color: dark ? TColors.light : TColors.darkGrey,
                          ),
                          prefixIcon: const Icon(Iconsax.bank),
                          isDense: true,
                        ),
                        isExpanded: true, // This makes the dropdown take full width
                        items: controller.banks.map((bank) {
                          return DropdownMenuItem<String>(
                            value: bank['name'] as String,
                            child: Text(
                              bank['name'] as String,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            controller.selectedBank.value = value;
                            final code = controller.getBankCodeByName(value);
                            if (code != null) {
                              controller.bankCode.text = code;
                            }
                          }
                        },
                        validator: (value) => controller.assignNuban.value && (value == null || value.isEmpty)
                            ? 'Please select your bank'
                            : null,
                      );
                    }),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    Container(
                      padding: const EdgeInsets.all(TSizes.sm),
                      decoration: BoxDecoration(
                        color: dark ? TColors.dark.withOpacity(0.2) : TColors.light.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(TSizes.borderRadiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(Iconsax.info_circle,
                            size: 16,
                            color: dark ? TColors.light : TColors.darkGrey,
                          ),
                          const SizedBox(width: TSizes.sm),
                          Expanded(
                            child: Text(
                              'Ensure your first and last name match your BVN records',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: dark ? TColors.light : TColors.darkGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              )),
            ],
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