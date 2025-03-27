import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TReferAndEarnScreen extends StatelessWidget {
  const TReferAndEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Refer And Earn'),
        showBackArrow: true,
        //    actions: [Icon(Iconsax.message_question)],
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
                color: TColors.grey, // Specify the border color
                width: 1, // Specify the border width
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                //    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 30,
                  // ),
                  Row(
                    children: [
                      Image.asset(
                        TImages.referandearn,
                        width: 30,
                        height: 30,
                        //   color: TColors.primary,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Total Earned: N0.00',
                          style: TextStyle(
                            fontSize: 15,
                            color: dark ? TColors.white : TColors.black,
                          ),
                          softWrap: true, // Allow text to wrap
                          //    maxLines:  null, // Allow multiple lines
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    TImages.referalgift,
                    width: 150,
                    height: 150,
                    //   color: TColors.primary,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Refer and earn a bonus of 6% on your first referral’s deposit. Share your unique code and earn!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: dark ? TColors.white : TColors.black,
                    ),
                    softWrap: true, // Allow text to wrap
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 130,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.transparent,
                          border: Border.all(
                            color: TColors.primary, // Specify the border color
                            width: 1, // Specify the border width
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "1234AB",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: TColors.primary,
                                ),
                                softWrap: true, // Allow text to wrap
                                //    maxLines:  null, // Allow multiple lines
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.copy,
                              color: TColors.primary,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 170,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: TColors.primary,
                          border: Border.all(
                            color: TColors.grey, // Specify the border color
                            width: 1, // Specify the border width
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Refer Friends Now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: TColors.white,
                            ),
                            softWrap: true, // Allow text to wrap
                            //    maxLines:  null, // Allow multiple lines
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
