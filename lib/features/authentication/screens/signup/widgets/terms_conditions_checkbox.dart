import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../controllers/signup/signup_controllerr.dart';

class TTermsAndConditionCheckbox extends StatelessWidget {
  const TTermsAndConditionCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: controller.privacyPolicy.value,
          onChanged: (value) =>
          controller.privacyPolicy.value = value ?? false,
          activeColor: TColors.primary,
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms of Service ',
                  style: TextStyle(
                    color: dark ? TColors.light : TColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: 'and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: dark ? TColors.light : TColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    ));
  }
}
