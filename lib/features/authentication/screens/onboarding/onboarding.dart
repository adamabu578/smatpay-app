import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smatpay/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:smatpay/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:smatpay/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:smatpay/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:smatpay/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TOnBoardingScreen extends StatelessWidget {
  const TOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.lightGrey,
      body: Stack(
        children: [
          /// Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          /// Skip Button
          const OnBoardingSkip(),

          /// Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          /// Circular Button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
