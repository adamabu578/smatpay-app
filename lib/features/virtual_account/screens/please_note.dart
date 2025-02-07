import 'package:flutter/material.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TPleaseNoteScreen extends StatelessWidget {
  const TPleaseNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
          width: double.infinity,
          height: 200,
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
                '\u{25cf} The account can only receive funds in Nigeria Naira (NGN)',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColors.white : TColors.black,
                    ),
              ),
              Text(
                '\u{25cf} Payments will take a few mins to reflect',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColors.white : TColors.black,
                    ),
              ),
              Text(
                '\u{25cf} There are no additional fees on deposits',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColors.white : TColors.black,
                    ),
              ),
            ],
          )),
    );
  }
}
