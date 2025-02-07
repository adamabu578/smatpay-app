// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smatpay/common/widgets/divider/divider.dart';
// import 'package:smatpay/common/widgets/images/t_circular_image.dart';
// import 'package:smatpay/common/widgets/drawer/widget/drawer_menu_tile.dart';
// import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
// import 'package:smatpay/features/personalization/controllers/user_controller.dart';
// import 'package:smatpay/utils/constants/colors.dart';
// import 'package:smatpay/utils/constants/image_strings.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class TDrawer extends StatelessWidget {
//   const TDrawer({
//     super.key,
//   //  required this.controller,
//   });

//   //final TUserController controller;

//   @override
//   Widget build(BuildContext context) {
//     // final dark = THelperFunctions.isDarkMode(context);
//     return Drawer(
//       child: ListView(
//         children: [
//           UserAccountsDrawerHeader(
//             decoration: const BoxDecoration(color: TColors.primary2),
//             accountName: Text(
//               controller.user.value.fullName,
//               style: Theme.of(context)
//                   .textTheme
//                   .headlineMedium!
//                   .apply(color: TColors.white),
//             ),
//             accountEmail: Text(
//               controller.user.value.email,
//               style: Theme.of(context).textTheme.bodyMedium!.apply(
//                     color: TColors.white,
//                   ),
//             ),
//             currentAccountPicture: Obx(() {
//               final networkImage = controller.user.value.profilePicture;
//               final image =
//                   networkImage.isNotEmpty ? networkImage : TImages.user;
//               return controller.imageUploading.value
//                   ? const TShimmerEffect(
//                       width: 50,
//                       height: 50,
//                       radius: 50,
//                     )
//                   : TCircularImage(
//                       image: image,
//                       width: 50,
//                       height: 50,
//                       isNetworkImage: networkImage.isNotEmpty,
//                     );
//             }),
//           ),
//           // DrawerHeader(
//           //   padding: EdgeInsets.all(0),
//           //   child: Container(
//           //     color: TColors.primary2,
//           //     child: Column(
//           //       children: [Text('Hi')],
//           //     ),
//           //   ),
//           // ),

//           TDrawerMenuTile(
//             icon: Icons.home,
//             title: 'The Switch',
//             children: [
//               {
//                 'icon': Icons.calendar_month,
//                 'title': 'My Calendar',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//               {
//                 'icon': Icons.notifications,
//                 'title': 'Notifications',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//               {
//                 'icon': Icons.menu_book_rounded,
//                 'title': 'Courses & Final Grades',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//               {
//                 'icon': Icons.badge,
//                 'title': 'Student ID',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//             ],
//           ),

//           // // TDivider(),

//           TDrawerMenuTile(
//             icon: Icons.headset_mic,
//             title: 'Services',
//             children: [
//               {
//                 'icon': Icons.library_books_outlined,
//                 'title': 'Student Service Directory',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//               {
//                 'icon': Icons.school,
//                 'title': 'Campus Locations',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//               {
//                 'icon': Icons.local_atm,
//                 'title': 'Student Service Ticket',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//             ],
//           ),
//           // // TDivider(),
//           TDrawerMenuTile(
//             icon: Icons.local_offer,
//             title: 'Promotion',
//             children: [
//               {
//                 'icon': Icons.attach_money,
//                 'title': 'Deals & Savings',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//               {
//                 'icon': Icons.event,
//                 'title': 'Events',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//             ],
//           ),
//           // // TDivider(),
//           TDrawerMenuTile(
//             icon: Icons.language,
//             title: 'Websites',
//             children: [
//               {
//                 'icon': Icons.language,
//                 'title': 'Switch Website',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//               {
//                 'icon': Icons.my_library_add,
//                 'title': 'Library Website',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//               {
//                 'icon': FontAwesomeIcons.linkedin,
//                 'title': 'LinkedIn Learning',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//               {
//                 'icon': Icons.contact_support,
//                 'title': 'Switch Assist for Students',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//               {
//                 'icon': Icons.monitor_heart,
//                 'title': 'Health and Well-being',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//             ],
//           ),
//           // // TDivider(),
//           TDrawerMenuTile(
//             icon: Icons.group,
//             title: 'Student Life',
//             children: [
//               {
//                 'icon': Icons.group_add_sharp,
//                 'title': 'Student Association',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//               {
//                 'icon': Icons.sports_soccer,
//                 'title': 'Student Clubs',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//             ],
//           ),
//           // // TDivider(),
//           TDrawerMenuTile(
//             icon: Icons.school,
//             title: 'Continuing Education',
//             children: [
//               {
//                 'icon': Icons.contact_phone_rounded,
//                 'title': 'Coned Department Contacts',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//               {
//                 'icon': FontAwesomeIcons.facebook,
//                 'title': 'Coned Facebook',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//               {
//                 'icon': FontAwesomeIcons.twitter,
//                 'title': 'Coned Twitter',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//               {
//                 'icon': FontAwesomeIcons.linkedin,
//                 'title': 'Coned LinkedIn',
//                 'onTap': () {
//                   // Handle navigation or other actions
//                 },
//               },
//             ],
//           ),
//           const TDivider(),
//           TDrawerMenuTile(
//             icon: Icons.home,
//             title: 'Home',
//             onTap: () {
//               // Handle navigation or other actions
//             },
//           ),
//           // // TDivider(),
//           TDrawerMenuTile(
//             icon: Icons.settings,
//             title: 'Settings',
//             onTap: () {
//               // Handle navigation or other actions
//             },
//           ),
//           // // TDivider(),
//           TDrawerMenuTile(
//             icon: Icons.security,
//             title: 'Contact Security',
//             onTap: () {
//               // Handle navigation or other actions
//             },
//           ),
//           // // TDivider(),
//           TDrawerMenuTile(
//             icon: Icons.back_hand_sharp,
//             title: 'Holds',
//             onTap: () {
//               // Handle navigation or other actions
//             },
//           ),
//           // // TDivider(),
//           TDrawerMenuTile(
//             icon: Icons.logout,
//             title: 'Logout',
//             onTap: () {
//               // Handle navigation or other actions
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
