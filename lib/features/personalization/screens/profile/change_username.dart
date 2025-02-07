import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/validators/validation.dart';

class TChangeUsername extends StatelessWidget {
  const TChangeUsername({super.key});

  @override
  Widget build(BuildContext context) {
    //  final controller = Get.put(TUpdateNameController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Change Username',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              'Use a nickname for easy verification. This name will appear on several pages',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Text field and Button
            Form(
                //     key: controller.updatedUserNameFormKey,
                child: Column(
              children: [
                TextFormField(
                  //    controller: controller.username,
                  validator: (value) =>
                      TValidator.validateEmptyText('Username', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.username,
                      prefixIcon: Icon(Iconsax.user)),
                ),

                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                /// Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      // onPressed: () => controller.updateUserName(),
                      child: const Text('Save')),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
