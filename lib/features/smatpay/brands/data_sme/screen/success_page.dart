import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/navigation_menu.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TSuccessPage extends StatelessWidget {
  final String message;

  TSuccessPage({required this.message});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: TAppBar(
        // title: Text('Purchase Successful'),

        actions: [
          GestureDetector(
              onTap: () => Get.to(() => TNavigationMenu()),
              child: Container(
                  padding: EdgeInsets.only(right: 25),
                  child: Text(
                    'Done',
                    style: Theme.of(context).textTheme.headlineSmall!.apply(
                          color: dark ? TColors.white : TColors.primary,
                          fontFamily: 'NotoSans',
                        ),
                  ))),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 100,
                color: Colors.green,
              ),
              SizedBox(height: 16),
              Text(
                message,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSans',
                  color: dark ? TColors.softGrey : TColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              // SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {
              //     // Use GetX to go back to home or previous page
              //     Get.back();
              //   },
              //   child: Text('Done'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
