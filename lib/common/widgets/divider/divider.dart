import 'package:flutter/material.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TDivider extends StatelessWidget {
  const TDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Divider(
      color: dark ? TColors.darkGrey : TColors.darkGrey,
      thickness: 0.5,
      indent: 0,
      endIndent: 0,
    );
  }
}
