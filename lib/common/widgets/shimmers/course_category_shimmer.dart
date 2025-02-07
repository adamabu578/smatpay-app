import 'package:flutter/material.dart';
import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
import 'package:smatpay/utils/constants/sizes.dart';

class TCourseCategoryShimmer extends StatelessWidget {
  const TCourseCategoryShimmer({super.key, this.itemCount = 3});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    // final courseCategoryController = Get.put(TCourseCategoryController());
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        //  itemCount: courseCategoryController.featuredCourseCategories.length,
        itemCount: itemCount,
        scrollDirection: Axis.vertical,
        separatorBuilder: (_, __) => const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image
              TShimmerEffect(
                width: double.infinity,
                height: 55,
                //  radius: 55,
              ),
              SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),

              // Text
              TShimmerEffect(width: double.infinity, height: 8)
            ],
          );
        },
      ),
    );
  }
}
