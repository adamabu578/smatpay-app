import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TSignupScreen extends StatelessWidget {
  const TSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.lightGrey,
      appBar: const TAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Text(
              TTexts.signupTitle,
              style: Theme.of(context).textTheme.headlineMedium!.apply(
                    color: dark ? TColors.primary : TColors.primary,
                  ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              'Enter your name, password and phone number',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? TColors.white : TColors.black,
                  ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Form
            const TSignupForm(),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            // /// Divider
            // const TFormDivider(),

            // const SizedBox(
            //   height: TSizes.spaceBtwSections,
            // ),

            // /// Social Button
            // const TSocialButton()
            const SizedBox(
              height: 140,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  TImages.messagetext,
                  width: 20,
                  height: 20,
                  color: dark ? TColors.primary : TColors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Need help?'),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Contact SmatPay Support',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.primary : TColors.primary,
                      ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
