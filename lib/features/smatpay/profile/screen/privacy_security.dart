import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TPrivacyAndSecurityScreen extends StatelessWidget {
  const TPrivacyAndSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Privacy & Security'),
        showBackArrow: true,
        //       actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: dark ? TColors.primary2 : TColors.white,
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
                                      Icons.person,
                                      size: 25,
                                      color: TColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Privacy and Policy',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: dark
                                            ? TColors.white
                                            : TColors.black,
                                        fontSize:
                                            15.0, // Increase the font size to 24.0
                                      ),

                                  //   .apply(color: TColors.black, ),
                                ),
                              ],
                            ),
                            const Icon(
                              Iconsax.arrow_right_3,
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
                                      Icons.person,
                                      size: 25,
                                      color: TColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Terms and Condition',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: dark
                                            ? TColors.white
                                            : TColors.black,
                                        fontSize:
                                            15.0, // Increase the font size to 24.0
                                      ),

                                  //   .apply(color: TColors.black, ),
                                ),
                              ],
                            ),
                            const Icon(
                              Iconsax.arrow_right_3,
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
