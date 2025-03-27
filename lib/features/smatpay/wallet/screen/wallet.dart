import 'package:smatpay/common/widgets/texts/section_heading.dart';
import 'package:smatpay/features/smatpay/profile/screen/notifications.dart';
import 'package:smatpay/features/virtual_account/screens/account_screen.dart';
import 'package:smatpay/features/virtual_account/screens/white_wallet_ui.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TWalletScreen extends StatelessWidget {
  const TWalletScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'My Wallet',
                  style: Theme.of(context).textTheme.headlineMedium!.apply(
                        color: dark ? TColors.white : TColors.black,
                      ),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const TNotificationScreen()),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(27),
                    child: Container(
                      height: 40,
                      width: 40,
                      color: TColors.secondary2,
                      child: const Icon(
                        Icons.notifications_none,
                        size: 25,
                        color: TColors.primary,
                      ),
                    ),
                  ),
                ),
              ]),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: TColors.primary.withOpacity(0.5),
                  //     offset: Offset(0, 6),
                  //     blurRadius: 12,
                  //     spreadRadius: 6,
                  //   ),
                  // ],
                  color: dark ? TColors.primary : TColors.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(children: [
                  Positioned(
                      left: 200,
                      child: Image.asset(
                        TImages.cardvector,
                        width: 150,
                        height: 150,
                        color: const Color.fromARGB(255, 110, 110, 249),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Wallet Balance',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: TColors.white),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Iconsax.eye,
                              color: TColors.white,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          child: TWalletBalanceWhiteScreen(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Get.to(() => TAccountScreen()),
                              child: Container(
                                height: 40,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: TColors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(TImages.cardreceive),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'Fund Wallet',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .apply(color: TColors.primary2),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.to(() => TAccountScreen()),
                              child: Container(
                                height: 40,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: TColors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(TImages.send),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'Withdraw',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .apply(color: TColors.primary2),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              const TSectionHeading(
                title: 'Wallet Transactions',
                showActionButton: true,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Image.asset(TImages.notransaction),
                  const Text('No transaction done yet.'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
