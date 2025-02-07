import 'package:flutter/material.dart';
import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
import 'package:smatpay/features/virtual_account/service/total_paystack_balance_service.dart';
import 'package:smatpay/utils/constants/colors.dart';

class TTotalPaystackBalanceScreen extends StatelessWidget {
  const TTotalPaystackBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: fetchAccountBalance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return
              //  CircularProgressIndicator()
              TShimmerEffect(
            width: 120,
            height: 20,
            radius: 20,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final balance = snapshot.data!;
          return Text(
            '₦${balance.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.headlineLarge!.apply(
                  color: TColors.black,
                  fontFamily: 'NotoSans',
                ),
          );
          //     Text(
          //   '\u{20A6}${balance.toStringAsFixed(2)}', // Unicode for ₦ is \u20A6
          //   style: TextStyle(
          //       fontFamily: 'NotoSans', // Use your added font
          //       fontSize: 34,
          //       fontWeight: FontWeight.bold),
          // );
        } else {
          return Text('No balance available');
        }
      },
    );
  }
}
