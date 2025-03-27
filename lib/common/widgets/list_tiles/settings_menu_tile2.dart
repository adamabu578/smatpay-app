import 'package:flutter/material.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TSettingsMenuTile2 extends StatelessWidget {
  const TSettingsMenuTile2(
      {super.key,
      required this.icon,
      required this.title,
      // this.subtitle = '',
      this.trailing,
      this.onTap});

  final Widget icon;
  //final IconData icon;
  // final String title;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListTile(
      leading: icon,
      // Icon(
      //   icon,
      //   size: 28,
      //   color: TColors.secondary2,
      // ), // TColors.primary
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: dark ? TColors.white : TColors.black,
              fontSize: 15.0, // Increase the font size to 24.0
            ),
        //   .apply(color: TColors.black, ),
      ),
      // subtitle: Text(
      //   subtitle,
      //   style: Theme.of(context).textTheme.labelMedium,
      // ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
