import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:smatpay/common/styles/spacing_styles.dart';
import 'package:smatpay/features/authentication/screens/login/widgets/login_form.dart';
import 'package:smatpay/features/authentication/screens/login/widgets/login_header.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TLoginScreen extends StatelessWidget {
  const TLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.lightGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              children: [
                /// Logo, Title & Sub-Title
                const TLoginHeader(),

                /// Forn
                const TLoginForm(),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.finger_scan,
                      color: TColors.primary,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Login with fingerprint')
                  ],
                ),
                const SizedBox(
                  height: 150,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      TImages.messagetext,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Need help?'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Contact SmatPay Support',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: TColors.primary),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
