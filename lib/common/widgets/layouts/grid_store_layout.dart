import 'package:flutter/material.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
//import 'package:smatpay/common/widgets/products/product_cards/product_card_vertical.dart';
//import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';

class TGridStoreLayout extends StatelessWidget {
  const TGridStoreLayout({
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
    String,
    String,
    String,
  ) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: TSizes.gridViewSpacing,
        crossAxisSpacing: TSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return itemBuilder(
              context,
              index,
              TImages.nikeLogo,
              'Course Registered',
              '25 Courses',
            );
          case 1:
            return itemBuilder(
              context,
              index,
              TImages.appleLogo,
              'Result Published',
              '2 Result',
            );
          case 2:
            return itemBuilder(
              context,
              index,
              TImages.adidasLogo,
              'Fees Paid',
              '310,000 NGN',
            );
          case 3:
            return itemBuilder(
              context,
              index,
              TImages.pumaLogo,
              'News',
              '10 Product',
            );
          default:
            return const SizedBox(); // Handle any additional items as needed
        }
      },

      // itemBuilder
      //TImages.clothIcon
    );
  }
}
