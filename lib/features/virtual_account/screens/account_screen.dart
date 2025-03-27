import 'package:flutter/material.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/virtual_account/screens/fetch_ui.dart';
import 'package:smatpay/features/virtual_account/screens/available_balance.dart';
import 'package:smatpay/features/virtual_account/screens/please_note.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TAccountScreen extends StatelessWidget {
  const TAccountScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: TAppBar(
        title: Text('Account Screen'), // Add an AppBar for better navigation
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TAvailableBalanceScreen(),

            SizedBox(
                width: double.infinity,
                height: 300, // Adjust the height as needed
                child: TFetchAccountDetailScreen()),

            //  Flexible(child: TVirtualAccountScreen()),
            //  Spacer(),
            // TVirtualAccountScreen(),
            // SizedBox(
            //   width: double.infinity,
            //   height: 300, // Adjust the height as needed
            //   child: TVirtualAccountScreen(),
            // ),
            TPleaseNoteScreen(),
          ],
        ),
      ),
    );
  }
}
