import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smatpay/data/repositories/authentication/authentication_repository.dart';
import 'package:smatpay/features/authentication/controllers/signup/verify_email_controller.dart';
import 'package:smatpay/utils/constants/colors.dart';
//import 'package:smatpay/features/authentication/screens/signup/signup.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TVerifyEmailScreen extends StatelessWidget {
  const TVerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TVerifyEmailController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.lightGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              // onPressed: () => Get.offAll(() => TLoginScreen()),
              onPressed: () => TAuthenticationRepository.instance.logout(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                ///Image
                Image(
                  image: const AssetImage(TImages.deliveredEmailIllustration),
                  width: THelperFunctions.screenWidth() * 0.6,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                ///Title $ Subtitle
                Text(
                  TTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium!.apply(
                        color: dark ? TColors.primary : TColors.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Text(
                  email ?? '',
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: dark ? TColors.white : TColors.black,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Text(
                  TTexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: dark ? TColors.white : TColors.black,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                ///Buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      //           onPressed: () => Get.to(() => TSuccessScreen(
                      //              image: TImages.successfullyRegisterAnimation,
                      // title: TTexts.yourAccountCreatedTitle,
                      // subTitle: TTexts.yourAccountCreatedSubTitle,
                      // onPressed: () => TLoginScreen()
                      //           )),
                      onPressed: () =>
                          controller.checkEmailVerificationStatus(),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(TSizes.md),
                          backgroundColor: TColors.primary,
                          side: const BorderSide(
                            color: TColors.primary,
                          )),
                      child: const Text(TTexts.tContinue)),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      // onPressed: () {},

                      onPressed: () => controller.sendEmailVerification(),
                      child: const Text(TTexts.resendEmail)),
                )
              ],
            )),
      ),
    );
  }
}
