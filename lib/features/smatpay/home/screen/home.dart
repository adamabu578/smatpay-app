import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:smatpay/common/widgets/images/t_circular_image.dart';
import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
import 'package:smatpay/common/widgets/texts/section_heading.dart';
import 'package:smatpay/features/personalization/controllers/user_controller.dart';
import 'package:smatpay/features/smatpay/brands/airtime/screen/buyairtime.dart';
import 'package:smatpay/features/smatpay/brands/data_sme/screen/success_page.dart';
import 'package:smatpay/features/smatpay/brands/data_sme/screen/testing_sme.dart';
import 'package:smatpay/features/smatpay/profile/screen/notifications.dart';
import 'package:smatpay/features/virtual_account/screens/account_screen.dart';
import 'package:smatpay/features/virtual_account/screens/white_wallet_ui.dart';
import 'package:smatpay/features/virtual_account/screens/wallet_balance_screen.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TsmatpayHomeScreen extends StatelessWidget {
  const TsmatpayHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TUserController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.lightGrey,
      appBar: TAppBar(
        title: Row(
          children: [
            Obx(() {
              final networkImage = controller.user.value.profilePicture;
              final image =
                  networkImage.isNotEmpty ? networkImage : TImages.smatpayuser;
              return controller.imageUploading.value
                  ? TShimmerEffect(
                      width: 80,
                      height: 80,
                      radius: 80,
                    )
                  : TCircularImage(
                      image: image,
                      width: 50,
                      height: 50,
                      isNetworkImage: networkImage.isNotEmpty,
                    );
            }),
            // Image.asset(
            //   TImages.smatpayuser,
            //   width: 30,
            //   height: 30,
            // ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Hi,',
              style: TextStyle(
                color: dark ? TColors.white : TColors.black,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Obx(() {
              if (controller.profileLoading.value) {
                // Display a shimmer loader while user profile is being loaded
                return const TShimmerEffect(width: 80, height: 15);
              } else {
                return Text(
                  controller.user.value
                      .firstName, // or controller.user.value.fullName,
                  style: TextStyle(
                    color: dark ? TColors.white : TColors.black,
                  ),
                );
              }
            }),
            const SizedBox(
              width: 8,
            ),
            Image.asset(
              TImages.wavehand,
              width: 25,
              height: 25,
            ),
          ],
        ),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(27),
            child: GestureDetector(
              onTap: () => Get.to(() => const TNotificationScreen()),
              child: Container(
                height: 30,
                width: 30,
                color: dark ? TColors.primary : TColors.secondary2,
                child: Icon(
                  Icons.notifications_none,
                  size: 25,
                  color: dark ? TColors.white : TColors.primary,
                ),
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     // Add onPressed logic for the announcement icon
          //   },
          //   icon: const Icon(
          //     Icons.notifications, // Use Material announcement icon
          //     color: Colors.black, // Customize the icon color if needed
          //   ),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
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
                  //  color: TColors.primary2,
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
                        //TColors.primary.withOpacity(0.6),
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
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            TImages.cardreceive,
                                            color: TColors.primary,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'Fund Wallet',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .apply(color: TColors.primary),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.to(() => TWalletBalanceScreen()),
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
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            TImages.send,
                                            color: TColors.primary,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'Withdraw',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .apply(color: TColors.primary),
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
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: TSectionHeading(
                title: 'Quick Links',
                showActionButton: false,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => TAccountScreen()),
                    child: const Column(
                      children: [
                        TCircularContainer(
                          width: 70,
                          height: 70,
                          backgroundColor: TColors.secondary2,
                          child: Icon(
                            Icons.account_balance,
                            //   size: 40,
                            color: TColors.primary,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Account')
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => const TBuyAirtimeScreen()),
                    child: const Column(
                      children: [
                        TCircularContainer(
                          width: 70,
                          height: 70,
                          backgroundColor: TColors.secondary2,
                          child: Icon(
                            Icons.phone_in_talk_sharp,
                            color: TColors.primary,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Airtime')
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => TTestingSmeDataScreen()),
                    child: const Column(
                      children: [
                        TCircularContainer(
                          width: 70,
                          height: 70,
                          backgroundColor: TColors.secondary2,
                          child: Icon(
                            Icons.wifi_outlined,
                            color: TColors.primary,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Data')
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => TSuccessPage(
                        message:
                            'Data purchased successfully! Amount: NGN ₦120')),
                    child: const Column(
                      children: [
                        TCircularContainer(
                          width: 70,
                          height: 70,
                          backgroundColor: TColors.secondary2,
                          child: Icon(
                            Icons.lightbulb,
                            color: TColors.primary,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Electricity')
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: TSectionHeading(
                title: 'Recent Transactions',
                showActionButton: true,
              ),
            ),
            Column(
              children: [
                Image.asset(TImages.notransaction),
                const Text('No transaction done yet.'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
