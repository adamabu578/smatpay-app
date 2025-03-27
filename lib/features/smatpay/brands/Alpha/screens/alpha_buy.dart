import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TAlphaBuyScreen extends StatelessWidget {
  const TAlphaBuyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Buy Alpha TopUp'),
        showBackArrow: true,
        actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              Image.asset(
                TImages.alphacaller,
                width: 100,
                height: 100,
              ),
              const Text('ALPHA'),
              const SizedBox(
                height: 20,
              ),
              // /// Phone No
              TextFormField(
                decoration: InputDecoration(
                  // prefixIcon: const Icon(Iconsax.call),
                  labelText: TTexts.amount,
                  labelStyle: TextStyle(
                    color: dark ? TColors.light : TColors.darkerGrey,
                  ),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              // /// Phone No
              TextFormField(
                decoration: InputDecoration(
                  // prefixIcon: const Icon(Iconsax.call),
                  labelText: TTexts.mobileNumber,
                  labelStyle: TextStyle(
                    color: dark ? TColors.light : TColors.darkerGrey,
                  ),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              const Text(
                  'Check the number carefully before proceeding transaction, mistaken number is not reversal'),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    //  => controller.signup(),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(TSizes.md),
                        backgroundColor: TColors.primary,
                        side: const BorderSide(
                          color: TColors.primary,
                        )),
                    child: const Text('Continue')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
