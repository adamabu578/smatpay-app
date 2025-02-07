import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/personalization/controllers/user_controller.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:smatpay/utils/validators/validation.dart';

class TReAuthLoginForm extends StatelessWidget {
  const TReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TUserController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Re-Authenticate User'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
              key: controller.reAuthFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Email
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: TValidator.validateEmail,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.direct_right,
                        ),
                        labelText: TTexts.email,
                        labelStyle: TextStyle(
                          color: dark ? TColors.white : TColors.black,
                        )),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  /// Password
                  Obx(
                    () => TextFormField(
                      obscureText: controller.hidePassword.value,
                      controller: controller.verifyPassword,
                      validator: (value) =>
                          TValidator.validateEmptyText('Password', value),
                      decoration: InputDecoration(
                          labelText: TTexts.password,
                          labelStyle: TextStyle(
                            color: dark ? TColors.white : TColors.black,
                          ),
                          prefixIcon: const Icon(
                            Iconsax.password_check,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value =
                                  !controller.hidePassword.value,
                              icon: const Icon(Iconsax.eye_slash))),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  /// Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () =>
                            controller.reAuthenticateEmailAndPasswordUser(),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(TSizes.md),
                            backgroundColor: TColors.primary,
                            side: const BorderSide(
                              color: TColors.primary,
                            )),
                        child: const Text('Verify')),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
