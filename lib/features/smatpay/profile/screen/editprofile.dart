import 'package:get/get.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/personalization/controllers/update_name_controller.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/validators/validation.dart';

class TEditProfileScreen extends StatelessWidget {
  const TEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TUpdateNameController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Edit Profile'),
        showBackArrow: true,
        //      actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 370,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: dark ? TColors.primary2 : TColors.white,
                border: Border.all(
                  color: TColors.grey, // Specify the border color
                  width: 1, // Specify the border width
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: controller.updatedUserNameFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),

                      /// First Name
                      TextFormField(
                        controller: controller.firstName,
                        validator: (value) =>
                            TValidator.validateEmptyText('First name', value),
                        expands: false,
                        decoration: InputDecoration(
                            labelText: TTexts.firstName,
                            labelStyle: TextStyle(
                              color: dark ? TColors.light : TColors.darkGrey,
                            ),
                            prefixIcon: const Icon(Iconsax.user)),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),

                      ///  Last Name
                      TextFormField(
                        controller: controller.lastName,
                        validator: (value) =>
                            TValidator.validateEmptyText('Last name', value),
                        expands: false,
                        decoration: InputDecoration(
                            labelText: TTexts.lastName,
                            labelStyle: TextStyle(
                              color: dark ? TColors.light : TColors.darkGrey,
                            ),
                            prefixIcon: const Icon(Iconsax.user)),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),

                      // /// Email
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //     prefixIcon: const Icon(Iconsax.direct),
                      //     labelText: TTexts.email,
                      //     labelStyle: TextStyle(
                      //       color: dark ? TColors.light : TColors.darkGrey,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: TSizes.spaceBtwInputFields,
                      // ),

                      /// Phone No
                      TextFormField(
                        controller: controller.phoneNo,
                        validator: (value) =>
                            TValidator.validatePhoneNumber(value),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.call),
                          labelText: TTexts.phoneNo,
                          labelStyle: TextStyle(
                            color: dark ? TColors.light : TColors.darkGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            ///Sign Up Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  //   onPressed: () {},
                  onPressed: () => controller.updateUserName(),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(TSizes.md),
                      backgroundColor: TColors.primary,
                      side: const BorderSide(
                        color: TColors.primary,
                      )),
                  child: const Text('Update')),
            ),
          ],
        ),
      )),
    );
  }
}
