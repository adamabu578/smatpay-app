import 'package:flutter/material.dart';
import 'package:smatpay/features/virtual_account/screens/black_wallet_ui.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TAvailableBalanceScreen extends StatelessWidget {
  const TAvailableBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
          // width: double.infinity,
          //  height: 250,
          decoration: BoxDecoration(
            color: dark ? Colors.transparent : Colors.transparent,
            // border: Border.all(color: dark ? TColors.secondary : Colors.grey),
            // borderRadius: BorderRadius.circular(12)
          ),
          // padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    TImages.nigeriaflag,
                    height: 15,
                    width: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Nigerian Naira',
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? TColors.primary : TColors.black,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'AVAILABLE BALANCE',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColors.white : TColors.darkGrey,
                    ),
              ),
              SizedBox(
                height: 15,
              ),
              // Text(
              //   '₦110.97',
              //   style: TextStyle(
              //       fontFamily: 'NotoSans', // Use your added font
              //       fontSize: 34,
              //       fontWeight: FontWeight.bold),
              //   // style: Theme.of(context).textTheme.headlineLarge!.apply(
              //   //       color: dark ? TColors.primary : TColors.black,
              //   //     ),
              // ),
              SizedBox(height: 40, child: TWalletBalanceBlackScreen()),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 130,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: TColors.primary,
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
                            "Add Money",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: TColors.white,
                            ),
                            softWrap: true, // Allow text to wrap
                            //    maxLines:  null, // Allow multiple lines
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.add,
                          color: TColors.white,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 140,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: TColors.primary,
                      border: Border.all(
                        color: TColors.grey, // Specify the border color
                        width: 1, // Specify the border width
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Send Money",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: TColors.white,
                            ),
                            softWrap: true, // Allow text to wrap
                            //    maxLines:  null, // Allow multiple lines
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.add,
                          color: TColors.white,
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
