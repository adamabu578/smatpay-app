import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';



class SignupSuccessScreen extends StatelessWidget {
  final VoidCallback onContinue;

  const SignupSuccessScreen({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: TSizes.spaceBtwSections),
              Text(
                'Account Created Successfully!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                'Your account has been successfully created. You can now login.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onContinue,
                  child: const Text('Continue to Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}