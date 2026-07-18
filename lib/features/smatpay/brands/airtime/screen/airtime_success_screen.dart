import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smatpay/common/widgets/success/transaction_success_screen.dart';
import 'buyairtime.dart';

/// Wrapper used by airtime purchase flow. Using the shared
/// [TransactionSuccessScreen] ensures uniformity across different
/// purchase screens (airtime, data, etc.).
class AirtimeSuccessScreen extends StatelessWidget {
  final String transactionId;
  final String message;

  const AirtimeSuccessScreen({
    Key? key,
    required this.transactionId,
    this.message = 'Airtime purchase successful!',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransactionSuccessScreen(
      title: 'Payment Successful!',
      message: message,
      transactionId: transactionId,
      showViewReceipt: true,
      onDone: () => Get.off(() => const TBuyAirtimeScreen()),
      onViewReceipt: () {
        // TODO: handle receipt view navigation
      },
    );
  }
}
