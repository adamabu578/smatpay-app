import 'package:flutter/material.dart';
import 'package:smatpay/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:smatpay/common/widgets/images/t_circular_image.dart';
import 'package:smatpay/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/enums.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    // this.imageUrl = 'imageUrl',
    // this.brandSubtitle = 'brandSubtitle',
    // this.brandTitle = 'brandTitle',
    required this.showBorder,
    this.onTap,
  });

  // final String imageUrl;
  // final String brandSubtitle;
  // final String brandTitle;

  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {},

      /// Container Design
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// Icon
            Flexible(
              child: TCircularImage(
                isNetworkImage: false,
                image: TImages.clothIcon,
                backgroundColor: Colors.transparent,
                overlayColor: dark ? TColors.white : TColors.black,
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),

            /// Text
            /// /// [Expanded] & Colum [MainAxisSize.min] is important to keep the element in the vertical center and also
            /// to keep text inside the boundary
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TBrandTitleWithVerificationIcon(
                    title: 'Nike',
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '256 products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
