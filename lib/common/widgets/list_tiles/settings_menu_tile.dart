import 'package:flutter/material.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TSettingsMenuTile extends StatelessWidget {
  const TSettingsMenuTile(
      {super.key,
      required this.icon,
      required this.title,
      this.subtitle = '',
      this.trailing,
      this.onTap});

  // final Widget icon;
  final IconData icon;
  final String title, subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: TColors.primary,
      ), // TColors.primary
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.apply(
              color: dark ? TColors.primary : TColors.primary,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.apply(
              color: dark ? TColors.white : TColors.black,
            ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
