import 'package:flutter/material.dart';

class TPaymentSuccessScreen extends StatelessWidget {
  const TPaymentSuccessScreen({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Payment Successful'),
    );
  }
}
