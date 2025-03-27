import 'package:smatpay/features/smatpay/brands/Alpha/screens/alpha_buy.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TAlphaTopUpData extends StatelessWidget {
  const TAlphaTopUpData({
    super.key,
    required this.title,
    required this.amount,
    required this.duration,
  });

  final String title, amount, duration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const TAlphaBuyScreen()),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 5,
                child: Row(
                  children: [
                    Image.asset(
                      TImages.alphacaller,
                      width: 30,
                      height: 30,
                      //   color: TColors.primary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 15, color: TColors.secondary),
                        softWrap: true, // Allow text to wrap
                        //    maxLines:  null, // Allow multiple lines
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(
                  amount,
                  style:
                      const TextStyle(fontSize: 15, color: TColors.secondary),
                  softWrap: true, // Allow text to wrap
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(
                  duration,
                  style:
                      const TextStyle(fontSize: 15, color: TColors.darkerGrey),
                  softWrap: true, // Allow text to wrap
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
