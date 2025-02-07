import 'package:flutter/material.dart';
import 'package:smatpay/common/styles/spacing_styles.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TSuccessScreen extends StatelessWidget {
  const TSuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.lightGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              // Image
              Image(
                image: const AssetImage(TImages.staticSuccessIllustration2),
                width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              ///Title $ Subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium!.apply(
                      color: dark ? TColors.primary : TColors.primary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium!.apply(
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
                    onPressed: onPressed,
                    //() => Get.to(() => const TNavigationMenu()),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(TSizes.md),
                        backgroundColor: TColors.primary,
                        side: const BorderSide(
                          color: TColors.primary,
                        )),
                    child: const Text(TTexts.tContinue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
