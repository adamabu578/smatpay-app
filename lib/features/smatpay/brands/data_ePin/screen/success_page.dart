import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smatpay/common/widgets/success/transaction_success_screen.dart';

import '../../../home/screen/home.dart';

class TSuccessPage extends StatelessWidget {
  final String transactionId;
  final String message;

  const TSuccessPage({
    super.key,
    required this.transactionId,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return TransactionSuccessScreen(
      message: message,
      transactionId: transactionId,
      onDone: () => Get.offAll(() => TsmatpayHomeScreen()),
    );
  }
}