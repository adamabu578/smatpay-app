import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TFormDivider extends StatelessWidget {
  const TFormDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Divider(
          color: dark ? TColors.darkGrey : TColors.darkGrey,
          thickness: 0.5,
          indent: 60,
          endIndent: 5,
        )),
        Text(
          TTexts.orSignInWith.capitalize!,
          //  style: Theme.of(context).textTheme.labelMedium,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(color: TColors.darkGrey),
        ),
        Flexible(
            child: Divider(
          color: dark ? TColors.darkGrey : TColors.darkGrey,
          thickness: 0.5,
          indent: 5,
          endIndent: 60,
        )),
      ],
    );
  }
}
