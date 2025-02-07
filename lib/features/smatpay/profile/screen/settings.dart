import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/personalization/controllers/user_controller.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TSettingsScreen extends StatelessWidget {
  TSettingsScreen({super.key});

  final controller = TUserController.instance;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Settings'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Container(
              width: double.infinity,
              height: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                  color: TColors.grey, // Specify the border color
                  width: 1, // Specify the border width
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Column(
                  children: [
                    //        SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(27),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    color: TColors.secondary2,
                                    child: const Icon(
                                      Iconsax.key,
                                      size: 20,
                                      color: TColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Password Setting',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: TColors.black,
                                        fontSize:
                                            15.0, // Increase the font size to 24.0
                                      ),

                                  //   .apply(color: TColors.black, ),
                                ),
                              ],
                            ),
                            const Icon(
                              Iconsax.arrow_right_3,
                              color: TColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// Terms And Conditions
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(27),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    color: TColors.secondary2,
                                    child: const Icon(
                                      Iconsax.lock,
                                      size: 20,
                                      color: TColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'SmartPay Pin Setting',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: TColors.black,
                                        fontSize:
                                            15.0, // Increase the font size to 24.0
                                      ),

                                  //   .apply(color: TColors.black, ),
                                ),
                              ],
                            ),
                            const Icon(
                              Iconsax.arrow_right_3,
                              color: TColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// Terms And Conditions
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(27),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    color: TColors.secondary2,
                                    child: const Icon(
                                      Iconsax.finger_scan,
                                      size: 20,
                                      color: TColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Activate Biometric',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: TColors.black,
                                        fontSize:
                                            15.0, // Increase the font size to 24.0
                                      ),

                                  //   .apply(color: TColors.black, ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.toggle_off,
                              size: 40.0,
                              color: TColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// Terms And Conditions
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(27),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    color: TColors.secondary2,
                                    child: const Icon(
                                      Iconsax.notification,
                                      size: 20,
                                      color: TColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Notification',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: TColors.black,
                                        fontSize:
                                            15.0, // Increase the font size to 24.0
                                      ),

                                  //   .apply(color: TColors.black, ),
                                ),
                              ],
                            ),
                            const Icon(
                              Iconsax.arrow_right_3,
                              color: TColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// Terms And Conditions
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () => controller.deleteAccountWarningPopup(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(27),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    color: TColors.secondary2,
                                    child: const Icon(
                                      Iconsax.profile_delete,
                                      size: 20,
                                      color: TColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Deactivate/Delete Account',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: TColors.black,
                                        fontSize:
                                            15.0, // Increase the font size to 24.0
                                      ),

                                  //   .apply(color: TColors.black, ),
                                ),
                              ],
                            ),
                            const Icon(
                              Iconsax.arrow_right_3,
                              color: TColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
