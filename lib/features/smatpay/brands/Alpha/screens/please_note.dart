import 'package:flutter/material.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TAlphaPleaseNoteScreen extends StatelessWidget {
  const TAlphaPleaseNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
              color: dark ? TColors.secondary : Colors.yellow.shade50,
              border: Border.all(
                  color: dark ? TColors.secondary : TColors.lightGrey),
              borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'PLEASE NOTE',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColors.primary : TColors.darkGrey,
                    ),
              ),
              Text(
                '\u{25cf} You will be redirected to our WhatsApp where we will manually credit your Alpha Wallet.',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColors.primary : TColors.black,
                    ),
              ),
            ],
          )),
    );
  }
}
