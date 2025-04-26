import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
import 'package:smatpay/features/virtual_account/controllers/balance_controller.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TWalletBalanceScreen extends StatefulWidget {
  @override
  _TWalletBalanceScreenState createState() => _TWalletBalanceScreenState();
}

class _TWalletBalanceScreenState extends State<TWalletBalanceScreen> {
  String? userId;
  String? customerId;
  double? accountBalance;
  bool isLoading = true;
  final BalanceController balanceController =
      Get.put(BalanceController()); // Initialize the controller

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    if (isLoading) {
      return Center(
          child: TShimmerEffect(
        width: double.infinity,
        height: double.infinity,
        radius: 20,
      ));
    } else if (accountBalance == null) {
      return Center(child: Text('No account balance available.'));
    } else {
      return Scaffold(
        backgroundColor: dark ? TColors.secondary : TColors.lightGrey,
        appBar: TAppBar(
          title: Text('Account Details'),
          showBackArrow: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return Text(
                  'Current Balance: ₦ ${balanceController.balance.value}',
                  style: Theme.of(context).textTheme.headlineSmall!.apply(
                        color: dark ? TColors.white : TColors.black,
                        fontFamily: 'NotoSans',
                      ),
                );
              }),

              Text('Account Balance: NGN ${accountBalance!.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18)),
              Text(
                  'Current Balance: ₦ ${balanceController.balance}'), // Display current balance
            ],
          ),
        ),
      );
    }
  }
}


