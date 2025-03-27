import 'package:flutter/material.dart';
//import 'package:smatpay/common/widgets/products/product_cards/product_card_vertical.dart';
//import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';

class TGridLayoutSingle extends StatelessWidget {
  const TGridLayoutSingle({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 288,
    required this.itemBuilder,
  });

  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(
    BuildContext,
    int,
  ) itemBuilder;

  @override
  Widget build(BuildContext context) {
    //final courseCategoryController = Get.put(TCourseCategoryController());
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
