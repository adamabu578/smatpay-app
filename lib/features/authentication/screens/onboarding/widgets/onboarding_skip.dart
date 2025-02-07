import 'package:flutter/material.dart';
import 'package:smatpay/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/device/device_utility.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

/// Skip Button
///
class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
        top: TDeviceUtils.getAppBarBarHeight(),
        right: TSizes.defaultSpace,
        child: TextButton(
            onPressed: () => OnBoardingController.instance.skipPage(),
            child: Text(
              'Skip',
              style: Theme.of(context).textTheme.labelLarge!.apply(
                    color: dark ? TColors.white : TColors.primary,
                  ),
            )));
  }
}
