import 'package:smatpay/common/widgets/images/t_circular_image.dart';
import 'package:smatpay/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
import 'package:smatpay/features/personalization/controllers/user_controller.dart';
import 'package:smatpay/features/smatpay/profile/screen/help_support.dart';
import 'package:smatpay/features/smatpay/profile/screen/personalinformation.dart';
import 'package:smatpay/features/smatpay/profile/screen/privacy_security.dart';
import 'package:smatpay/features/smatpay/profile/screen/refer_earn.dart';
import 'package:smatpay/features/smatpay/profile/screen/settings.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TProfileScreensmatpay extends StatelessWidget {
  const TProfileScreensmatpay({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TUserController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Profile',
                  style: Theme.of(context).textTheme.headlineMedium!.apply(
                        color: dark ? TColors.white : TColors.black,
                      ),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => TSettingsScreen()),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(27),
                    child: Container(
                      height: 40,
                      width: 40,
                      color: dark ? TColors.primary : TColors.secondary2,
                      child: Icon(
                        Icons.settings,
                        size: 25,
                        color: dark ? TColors.white : TColors.primary,
                      ),
                    ),
                  ),
                ),
              ]),
              const SizedBox(
                height: 30,
              ),

              Obx(() {
                final networkImage = controller.user.value.profilePicture;
                final image = networkImage.isNotEmpty
                    ? networkImage
                    : TImages.smatpayuser;
                return controller.imageUploading.value
                    ? TShimmerEffect(
                        width: 80,
                        height: 80,
                        radius: 80,
                      )
                    : TCircularImage(
                        image: image,
                        width: 130,
                        height: 130,
                        isNetworkImage: networkImage.isNotEmpty,
                      );
              }),
              const SizedBox(height: 3), // Adjust this value as needed
              Text(
                controller.user.value.fullName,
                style: Theme.of(context).textTheme.headlineSmall!.apply(
                      color: dark ? TColors.white : TColors.black,
                    ),
              ),
              Text(controller.user.value.email,
                  style: TextStyle(
                    fontSize: 12,
                    color: dark ? TColors.primary : TColors.primary,
                  )),

              const SizedBox(height: 20),

              TSettingsMenuTile(
                icon: Icons.person,
                title: 'Personal Information',
                subtitle: 'View and edit your information',
                trailing: Icon(
                  Iconsax.arrow_right_3,
                  color: dark ? TColors.white : TColors.primary,
                ),
                onTap: () => Get.to(() => const TPersonalInformationScreen()),
              ),

              TSettingsMenuTile(
                icon: Icons.card_giftcard,
                title: 'Refer and Earn',
                subtitle: 'Referrals & Commissions',
                trailing: Icon(
                  Iconsax.arrow_right_3,
                  color: dark ? TColors.white : TColors.primary,
                ),
                onTap: () => Get.to(() => const TReferAndEarnScreen()),
              ),
              TSettingsMenuTile(
                icon: Iconsax.headphone5,
                title: 'Support',
                subtitle: 'Contact smartpay for help',
                trailing: Icon(
                  Iconsax.arrow_right_3,
                  color: dark ? TColors.white : TColors.primary,
                ),
                onTap: () => Get.to(() => const THelpAndSupportScreen()),
              ),
              TSettingsMenuTile(
                icon: Icons.security,
                title: 'Security Centre',
                subtitle: 'Privacy & Security',
                trailing: Icon(
                  Iconsax.arrow_right_3,
                  color: dark ? TColors.white : TColors.primary,
                ),
                onTap: () => Get.to(() => const TPrivacyAndSecurityScreen()),
              ),
              TSettingsMenuTile(
                icon: Iconsax.star5,
                title: 'Rate Us',
                subtitle: 'Give us a rating',
                trailing: Icon(
                  Iconsax.arrow_right_3,
                  color: dark ? TColors.white : TColors.primary,
                ),
                onTap: () {},
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () => controller.logoutAccountWarningPopup(),
                //() => Get.to(() => const TLoginScreen()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.logout,
                      color: dark ? TColors.white : TColors.primary,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: dark ? TColors.primary : TColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
