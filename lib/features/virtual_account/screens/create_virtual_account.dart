import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/virtual_account/controllers/create_virtual_account_controller.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class CreateVirtualAccountScreen extends StatelessWidget {
  const CreateVirtualAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateVirtualAccountController());
    final dark = THelperFunctions.isDarkMode(context);
    final formKey = GlobalKey<FormState>(); // Add form key

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Create Virtual Account',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey, // Assign the form key
          child: Column(
            children: [
              // BVN Field
              TextFormField(
                controller: controller.bvnController,
                decoration: InputDecoration(
                  labelText: 'BVN',
                  hintText: 'Enter your 11-digit BVN',
                  prefixIcon: const Icon(Icons.fingerprint),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: dark ? TColors.darkerGrey : TColors.white,
                ),
                keyboardType: TextInputType.number,
                maxLength: 11,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your BVN';
                  }
                  if (value.length != 11) {
                    return 'BVN must be 11 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Account Number Field
              TextFormField(
                controller: controller.accountNumberController,
                decoration: InputDecoration(
                  labelText: 'Account Number',
                  hintText: 'Enter your account number',
                  prefixIcon: const Icon(Icons.account_balance),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: dark ? TColors.darkerGrey : TColors.white,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your account number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Bank Code Field
              TextFormField(
                controller: controller.bankCodeController,
                decoration: InputDecoration(
                  labelText: 'Bank Code',
                  hintText: 'Enter bank code (e.g., 076)',
                  prefixIcon: const Icon(Icons.code),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: dark ? TColors.darkerGrey : TColors.white,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter bank code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Create Button
              Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                    if (formKey.currentState!.validate()) { // Use the form key here
                      await controller.createVirtualAccount();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: controller.isLoading.value
                        ? Theme.of(context).primaryColor.withOpacity(0.6)
                        : Theme.of(context).primaryColor,
                  ),
                  child: controller.isLoading.value
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text(
                    'Create Virtual Account',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}