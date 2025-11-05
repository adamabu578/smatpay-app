import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/smatpay/brands/Alpha/screens/alpha_topup.dart';
import 'package:smatpay/features/smatpay/brands/airtime/screen/buyairtime.dart';
import 'package:smatpay/features/smatpay/brands/cableTv/cabletv.dart';
import 'package:smatpay/features/smatpay/brands/education/education.dart';
import 'package:smatpay/features/smatpay/brands/electricity/electricity.dart';
import 'package:smatpay/features/smatpay/brands/gift/gift.dart';
import 'package:smatpay/features/smatpay/brands/smile/smile_buy.dart';
import 'package:smatpay/features/smatpay/epin_service/screens/epin_screen.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TServicesScreen extends StatelessWidget {
  const TServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: TAppBar(
        title: Text(
          'Services',
          style: Theme.of(context).textTheme.headlineMedium!.apply(
                color: dark ? TColors.white : TColors.black,
              ),
        ),
        // showBackArrow: true,
        //   actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                MainAxisAlignment.center, // Center items vertically
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'SmatPay provides services for simplified bills payment',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                        color: dark ? TColors.white : TColors.black,
                      ),
                ),
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => const TAlphaTopUpDataScreen()),
                    //    onTap: () => Get.to(() => const TAlphaDataScreen()),
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: dark
                            ? TColors.primary.withOpacity(0.4)
                            : TColors.white,
                        // Colors.red.shade50,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //   Icon(Icons.phone_in_talk_sharp),
                          Image.asset(
                            TImages.alphacaller,
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Alpha Caller',
                            style: TextStyle(
                              color: dark ? TColors.white : TColors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  GestureDetector(
                    onTap: () => Get.to(() => const TSmileBuyScreen()),
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: dark
                            ? TColors.primary.withOpacity(0.4)
                            : TColors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            TImages.smilevoice,
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Smile Voice',
                            style: TextStyle(
                              color: dark ? TColors.white : TColors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => const TBuyAirtimeScreen()),
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: dark
                            ? TColors.primary.withOpacity(0.4)
                            : TColors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone_in_talk_sharp),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Buy Airtime',
                            style: TextStyle(
                              color: dark ? TColors.white : TColors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () =>
                        Get.to(() => TEPinDataScreen()), //TSmeDataScreen()
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: dark
                            ? TColors.primary.withOpacity(0.4)
                            : TColors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //   Icon(Icons.phone_in_talk_sharp),
                          Icon(Icons.wifi_outlined),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Buy Data',
                            style: TextStyle(
                              color: dark ? TColors.white : TColors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  GestureDetector(
                    onTap: () => Get.to(() => const ElectricityPurchaseScreen()),
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: dark
                            ? TColors.primary.withOpacity(0.4)
                            : TColors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lightbulb),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Electricity',
                            style: TextStyle(
                              color: dark ? TColors.white : TColors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() =>  TCableTvScreen()),
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: dark
                            ? TColors.primary.withOpacity(0.4)
                            : TColors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.tv),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Cable TV',
                            style: TextStyle(
                              color: dark ? TColors.white : TColors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => const TGiftScreen()),
                      child: Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: dark
                              ? TColors.primary.withOpacity(0.4)
                              : TColors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //   Icon(Icons.phone_in_talk_sharp),
                            Icon(Icons.wallet_giftcard_sharp),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Gift',
                              style: TextStyle(
                                color: dark ? TColors.white : TColors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => const TEducationScreen()),
                      child: Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: dark
                              ? TColors.primary.withOpacity(0.4)
                              : TColors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.school),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Education',
                              style: TextStyle(
                                color: dark ? TColors.white : TColors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () => Get.to(() => const TBuyAirtimeScreen()),
                    //   child: Container(
                    //     height: 110,
                    //     width: 110,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       color: dark
                    //           ? TColors.primary.withOpacity(0.4)
                    //           : TColors.white,
                    //     ),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(Icons.sports_soccer),
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //         Text(
                    //           'Betting',
                    //           style: TextStyle(
                    //             color: dark ? TColors.white : TColors.black,
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   width: double.infinity,
              //   height: 700,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     //   color: TColors.black
              //     color: Colors.white,
              //     border: Border.all(
              //       color: TColors.grey, // Specify the border color
              //       width: 1, // Specify the border width
              //     ),
              //   ),
              //   child: Column(
              //     children: [
              //       const SizedBox(
              //         height: 20,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           GestureDetector(
              //             onTap: () => Get.to(() => const TAlphaDataScreen()),
              //             child: Container(
              //               height: 150,
              //               width: 150,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(20),
              //                 color: Colors.red.shade50,
              //               ),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   //   Icon(Icons.phone_in_talk_sharp),
              //                   Image.asset(
              //                     TImages.alphacaller,
              //                     width: 40,
              //                     height: 40,
              //                   ),
              //                   const SizedBox(
              //                     height: 10,
              //                   ),
              //                   const Text('Alpha Caller')
              //                 ],
              //               ),
              //             ),
              //           ),
              //           // SizedBox(
              //           //   width: 10,
              //           // ),
              //           GestureDetector(
              //             onTap: () => Get.to(() => const TSmileBuyScreen()),
              //             child: Container(
              //               height: 150,
              //               width: 150,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(20),
              //                 color: Colors.green.shade50,
              //               ),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Image.asset(
              //                     TImages.smilevoice,
              //                     width: 40,
              //                     height: 40,
              //                   ),
              //                   const SizedBox(
              //                     height: 10,
              //                   ),
              //                   const Text('Smile Voice')
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: 20,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           GestureDetector(
              //             onTap: () => Get.to(() => const TBuyAirtimeScreen()),
              //             child: Container(
              //               height: 150,
              //               width: 150,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(20),
              //                 color: Colors.blue.shade50,
              //               ),
              //               child: const Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Icon(Icons.phone_in_talk_sharp),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   Text('Buy Airtime')
              //                 ],
              //               ),
              //             ),
              //           ),
              //           // SizedBox(
              //           //   width: 10,
              //           // ),
              //           GestureDetector(
              //             onTap: () => Get.to(() => const TBuyDataScreen()),
              //             child: Container(
              //               height: 150,
              //               width: 150,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(20),
              //                 color: Colors.orange.shade50,
              //               ),
              //               child: const Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Icon(Icons.wifi_outlined),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   Text('Buy Data')
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: 20,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           GestureDetector(
              //             onTap: () => Get.to(() => const TElectricityScreen()),
              //             child: Container(
              //               height: 150,
              //               width: 150,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(20),
              //                 color: Colors.yellow.shade50,
              //               ),
              //               child: const Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Icon(Icons.lightbulb),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   Text('Electricity')
              //                 ],
              //               ),
              //             ),
              //           ),
              //           // SizedBox(
              //           //   width: 10,
              //           // ),
              //           GestureDetector(
              //             onTap: () => Get.to(() => const TCableTvScreen()),
              //             child: Container(
              //               height: 150,
              //               width: 150,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(20),
              //                 color: Colors.purple.shade50,
              //               ),
              //               child: const Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Icon(Icons.tv),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   Text('Cable TV')
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: 20,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           GestureDetector(
              //             onTap: () => Get.to(() => const TGiftScreen()),
              //             child: Container(
              //               height: 150,
              //               width: 150,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(20),
              //                 color: Colors.blueGrey.shade50,
              //               ),
              //               child: const Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Icon(Icons.wallet_giftcard_sharp),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   Text('Gift')
              //                 ],
              //               ),
              //             ),
              //           ),
              //           // SizedBox(
              //           //   width: 10,
              //           // ),
              //           GestureDetector(
              //             onTap: () => Get.to(() => const TEducationScreen()),
              //             child: Container(
              //               height: 150,
              //               width: 150,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(20),
              //                 color: Colors.cyan.shade50,
              //               ),
              //               child: const Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Icon(Icons.school),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   Text('Education')
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
