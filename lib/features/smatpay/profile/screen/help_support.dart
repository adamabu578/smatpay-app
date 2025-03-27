import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/common/widgets/list_tiles/settings_menu_tile2.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class THelpAndSupportScreen extends StatelessWidget {
  const THelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Help & Support'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Container(
              width: double.infinity,
              height: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: dark ? TColors.primary2 : TColors.white,
                border: Border.all(
                  color: TColors.grey,
                  width: 1,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Column(
                  children: [
                    Image.asset(
                      TImages.supporthr,
                      width: 80,
                      height: 80,
                      color: dark ? TColors.white : TColors.primary,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Hello, eBarry',
                      style: Theme.of(context).textTheme.headlineSmall!.apply(
                            color: dark ? TColors.primary : TColors.primary,
                          ),
                    ),
                    Text('How can we help you?',
                        style: TextStyle(
                          fontSize: 14,
                          color: dark ? TColors.white : TColors.black,
                        )),
                    const SizedBox(height: 40),
                    const TSettingsMenuTile2(
                      icon: Icon(
                        Iconsax.headphone5,
                        color: TColors.primary,
                      ),

                      title: 'Contact Live Chat',
                      trailing: Icon(
                        Iconsax.arrow_right_3,
                        color: TColors.primary,
                      ),
                      //      onTap: () => Get.to(() => const TPersonalInformationScreen()),
                    ),
                    const TSettingsMenuTile2(
                      icon: Icon(
                        Icons.message,
                        color: TColors.primary,
                      ),
                      title: 'Send us an Email',
                      trailing: Icon(
                        Iconsax.arrow_right_3,
                        color: TColors.primary,
                      ),
                      //      onTap: () => Get.to(() => const TReferAndEarnScreen()),
                    ),
                    const TSettingsMenuTile2(
                      icon: Icon(
                        Iconsax.message_question,
                        color: TColors.primary,
                      ),

                      title: 'FAQs',
                      trailing: Icon(
                        Iconsax.arrow_right_3,
                        color: TColors.primary,
                      ),
                      //      onTap: () => Get.to(() => const THelpAndSupportScreen()),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
