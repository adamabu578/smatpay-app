import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TNotificationScreen extends StatelessWidget {
  const TNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Notification'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                color: TColors.grey, // Specify the border color
                width: 1, // Specify the border width
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                children: [
                  //        SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 8,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(27),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    color: TColors.secondary2,
                                    child: const Icon(
                                      Icons.notifications,
                                      size: 20,
                                      color: TColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Push Notification',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              color: TColors.black,
                                              fontSize:
                                                  15.0, // Increase the font size to 24.0
                                            ),
                                        softWrap: true,

                                        //   .apply(color: TColors.black, ),
                                      ),
                                      Text(
                                        'Enable or disable push notification',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: TColors.black,
                                              fontSize:
                                                  13.0, // Increase the font size to 24.0
                                            ),
                                        softWrap: true,
                                        // overflow: TextOverflow
                                        //     .ellipsis, // Prevent overflow by adding ellipsis

                                        //   .apply(color: TColors.black, ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Flexible(
                            flex: 1,
                            child: Icon(
                              Icons.toggle_off,
                              size: 40.0,
                              color: TColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// Terms And Conditions
                  //        SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 8,
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(27),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    color: TColors.secondary2,
                                    child: const Icon(
                                      Icons.notifications,
                                      size: 20,
                                      color: TColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email Notification',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              color: TColors.black,
                                              fontSize:
                                                  15.0, // Increase the font size to 24.0
                                            ),
                                        softWrap: true,

                                        //   .apply(color: TColors.black, ),
                                      ),
                                      Text(
                                        'Enable or disable email notification',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: TColors.black,
                                              fontSize:
                                                  13.0, // Increase the font size to 24.0
                                            ),
                                        softWrap: true,
                                        // overflow: TextOverflow
                                        //     .ellipsis, // Prevent overflow by adding ellipsis

                                        //   .apply(color: TColors.black, ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Flexible(
                            flex: 1,
                            child: Icon(
                              Icons.toggle_off,
                              size: 40.0,
                              color: TColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
