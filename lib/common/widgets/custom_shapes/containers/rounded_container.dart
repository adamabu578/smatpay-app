import 'package:flutter/material.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/sizes.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = TSizes.cardRadiusLg,
    this.margin,
    this.padding,
    this.child,
    this.backgroundColor = TColors.white,
    this.borderColor = TColors.borderPrimary,
    this.showBorder = false,
  });

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Color backgroundColor;
  final Color borderColor;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor) : null,
        // color: TColors.textWhite.withOpacity(0.1)
      ),
      child: child,
    );
  }
}
