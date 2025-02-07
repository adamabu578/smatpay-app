// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:smatpay/common/widgets/images/t_circular_image.dart';
// import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
// import 'package:smatpay/features/personalization/controllers/user_controller.dart';
// import 'package:smatpay/utils/constants/colors.dart';
// import 'package:smatpay/utils/constants/image_strings.dart';

// class TUserProfileTile extends StatelessWidget {
//   const TUserProfileTile({
//     super.key,
//     required this.onPressed,
//   });
//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     final controller = TUserController.instance;
//     return ListTile(
//       leading: Obx(() {
//         final networkImage = controller.user.value.profilePicture;
//         final image = networkImage.isNotEmpty ? networkImage : TImages.user;
//         return controller.imageUploading.value
//             ? const TShimmerEffect(
//                 width: 50,
//                 height: 50,
//                 radius: 50,
//               )
//             : TCircularImage(
//                 image: image,
//                 width: 50,
//                 height: 50,
//                 isNetworkImage: networkImage.isNotEmpty,
//               );
//       }),
//       //   const TCircularImage(image: TImages.user, width: 50, height: 50, padding: 0,),
//       title: Text(
//         controller.user.value.fullName,
//         style: Theme.of(context)
//             .textTheme
//             .headlineMedium!
//             .apply(color: TColors.white),
//       ),
//       subtitle: Text(
//         controller.user.value.email,
//         style: Theme.of(context).textTheme.bodyMedium!.apply(
//               color: TColors.white,
//             ),
//       ),
//       trailing: IconButton(
//           onPressed: onPressed,
//           icon: const Icon(
//             Iconsax.edit,
//             color: TColors.white,
//           )),
//     );
//   }
// }

// // class TUserProfileTile extends StatelessWidget {
// //   const TUserProfileTile({
// //     super.key,
// //     required this.onPressed,
// //   });
// //   final VoidCallback onPressed;

// //   @override
// //   Widget build(BuildContext context) {
// //     return ListTile(
// //       leading: const TCircularImage(
// //         image: TImages.user,
// //         width: 50,
// //         height: 50,
// //         padding: 0,
// //       ),
// //       title: Text(
// //         'eBarry',
// //         style: Theme.of(context)
// //             .textTheme
// //             .headlineMedium!
// //             .apply(color: TColors.white),
// //       ),
// //       subtitle: Text(
// //         'support@ebarry.com',
// //         style: Theme.of(context).textTheme.bodyMedium!.apply(
// //               color: TColors.white,
// //             ),
// //       ),
// //       trailing: IconButton(
// //           onPressed: onPressed,
// //           icon: const Icon(
// //             Iconsax.edit,
// //             color: TColors.white,
// //           )),
// //     );
// //   }
// // }
