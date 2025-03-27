import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/common/widgets/images/t_circular_image.dart';
import 'package:smatpay/common/widgets/list_tiles/settings_menu_tile2.dart';
import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
import 'package:smatpay/features/personalization/controllers/user_controller.dart';
import 'package:smatpay/features/smatpay/profile/screen/editprofile.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TPersonalInformationScreen extends StatelessWidget {
  const TPersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TUserController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: TAppBar(
        title: Text(
          'Personnal Information',
          style: Theme.of(context).textTheme.titleLarge!.apply(
                color: dark ? TColors.white : TColors.black,
              ),
        ),
        showBackArrow: true,
        //     actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: dark ? TColors.primary2 : TColors.white,
                  border: Border.all(
                    color: TColors.grey, // Specify the border color
                    width: 1, // Specify the border width
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Obx(() {
                        final networkImage =
                            controller.user.value.profilePicture;
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
                      const SizedBox(height: 15), // Adjust this value as needed
                      Container(
                        width: 190,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.purple.shade50,
                          border: Border.all(
                            color: TColors.grey, // Specify the border color
                            width: 1, // Specify the border width
                          ),
                        ),
                        child:
                            // TextButton(
                            //   onPressed: () =>
                            //       controller.uploadUserProfilePicture(),
                            //   child:
                            //   Text(
                            //     'Change Photo',
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .bodySmall!
                            //         .apply(color: TColors.primary),
                            //   ),
                            // ),

                            GestureDetector(
                          onTap: () => controller.uploadUserProfilePicture(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.image,
                                color: TColors.primary,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Change Photo',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .apply(color: TColors.primary),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TSettingsMenuTile2(
                        icon: const Icon(
                          Iconsax.user4,
                          color: TColors.primary,
                        ),
                        title: 'Edit Profile',
                        //    subtitle: 'View and edit your information',
                        trailing: Icon(
                          Iconsax.arrow_right_3,
                          color: dark ? TColors.primary : TColors.primary,
                        ),
                        onTap: () => Get.to(() => const TEditProfileScreen()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 300,
            ),
            GestureDetector(
              onTap: () => controller.deleteAccountWarningPopup(),
              //() => Get.to(() => const TLoginScreen()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   Iconsax.logout,
                  //   color: dark ? TColors.white : TColors.primary,
                  // ),
                  // SizedBox(
                  //   width: 6,
                  // ),
                  Text(
                    'Close Account',
                    style: TextStyle(
                      color: dark ? Colors.red : Colors.red,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
