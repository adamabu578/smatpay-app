import 'package:flutter/material.dart';
import 'package:smatpay/utils/constants/colors.dart';

class TDrawerMenuTile extends StatelessWidget {
  const TDrawerMenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.children,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final List<Map<String, dynamic>>? children;

  @override
  Widget build(BuildContext context) {
    if (children != null && children!.isNotEmpty) {
      return ExpansionTile(
        leading: Icon(
          icon,
          color: TColors.secondary2,
        ),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .apply(color: TColors.primary2),
        ),
        children: children!.map((child) {
          return ListTile(
            leading: Icon(child['icon'], color: TColors.primary2, size: 20),
            title: Text(
              child['title'],
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .apply(color: TColors.primary2),
            ),
            onTap: child['onTap'],
          );
        }).toList(),
      );
    } else {
      return ListTile(
        leading: Icon(
          icon,
          color: TColors.secondary2,
        ),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .apply(color: TColors.primary2),
        ),
        onTap: onTap,
      );
    }
  }
}





// import 'package:flutter/material.dart';
// import 'package:smatpay/utils/constants/colors.dart';

// class TDrawerMenuTile extends StatelessWidget {
//   const TDrawerMenuTile({
//     super.key,
//     required this.icon,
//     required this.title,
//     this.onTap,
//     this.children,
//   });

//   final IconData icon;
//   final String title;
//   final VoidCallback? onTap;
//   final List<Widget>? children;

//   @override
//   Widget build(BuildContext context) {
//     if (children != null && children!.isNotEmpty) {
//       return ExpansionTile(
//         leading: Icon(
//           icon,
//           color: TColors.primary2,
//         ),
//         title: Text(
//           title,
//           style: Theme.of(context)
//               .textTheme
//               .titleMedium!
//               .apply(color: TColors.primary2),
//         ),
//         children: children!,
//         onExpansionChanged: (isExpanded) {
//           if (!isExpanded && onTap != null) {
//             onTap!();
//           }
//         },
//       );
//     } else {
//       return ListTile(
//         leading: Icon(
//           icon,
//           color: TColors.primary2,
//         ),
//         title: Text(
//           title,
//           style: Theme.of(context)
//               .textTheme
//               .titleMedium!
//               .apply(color: TColors.primary2),
//         ),
//         onTap: onTap,
//       );
//     }
//   }
// }



