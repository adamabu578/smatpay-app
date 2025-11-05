import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';

import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

import '../../controllers/electricity_controller.dart';

class ElectricityPurchaseScreen extends StatelessWidget {
  const ElectricityPurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ElectricityController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Ibadan Electricity',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Meter Type Selection
              _buildMeterTypeSelector(controller, dark, context),
              const SizedBox(height: 20),

              // Meter Number Input
              _buildMeterNumberInput(controller, context),
              const SizedBox(height: 20),

              // Verify Button
              _buildVerifyButton(controller, context),
              const SizedBox(height: 20),

              // Customer Details (if verified)
              Obx(() => controller.customerName.value.isNotEmpty
                  ? _buildCustomerDetails(controller, dark, context)
                  : const SizedBox()),

              // Amount Selection
              Obx(() => controller.canVend.value
                  ? _buildAmountSelection(controller, dark, context)
                  : const SizedBox()),

              // Purchase Button
              Obx(() => controller.selectedAmount.value > 0
                  ? _buildPurchaseButton(controller, context)
                  : const SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMeterTypeSelector(
      ElectricityController controller, bool dark, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meter Type',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Obx(
                    () => ChoiceChip(
                  label: const Text('Prepaid'),
                  selected: controller.meterType.value == 'prepaid',
                  onSelected: (selected) {
                    if (selected) {
                      controller.meterType.value = 'prepaid';
                      controller.resetCustomerDetails();
                    }
                  },
                  selectedColor: TColors.primary,
                  labelStyle: TextStyle(
                    color: controller.meterType.value == 'prepaid'
                        ? Colors.white
                        : dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Obx(
                    () => ChoiceChip(
                  label: const Text('Postpaid'),
                  selected: controller.meterType.value == 'postpaid',
                  onSelected: (selected) {
                    if (selected) {
                      controller.meterType.value = 'postpaid';
                      controller.resetCustomerDetails();
                    }
                  },
                  selectedColor: TColors.primary,
                  labelStyle: TextStyle(
                    color: controller.meterType.value == 'postpaid'
                        ? Colors.white
                        : dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMeterNumberInput(
      ElectricityController controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meter / Account Number',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: TextEditingController(text: controller.meterNumber.value),
          onChanged: (value) => controller.meterNumber.value = value,
          decoration: InputDecoration(
            hintText: 'Enter Meter Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildVerifyButton(
      ElectricityController controller, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Obx(
            () => ElevatedButton(
          onPressed: controller.isVerifying.value ||
              controller.meterNumber.value.isEmpty
              ? null
              : () => controller.verifyRecipient(),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: controller.isVerifying.value
              ? const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          )
              : const Text('Verify'),
        ),
      ),
    );
  }

  Widget _buildCustomerDetails(
      ElectricityController controller, bool dark, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Beneficiaries',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          color: dark ? TColors.dark : TColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.customerName.value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                controller.customerAddress.value,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Account Type: ${controller.accountType.value}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmountSelection(
      ElectricityController controller, bool dark, BuildContext context) {
    final amounts = controller.meterType.value == 'prepaid'
        ? controller.prepaidAmounts
        : controller.postpaidAmounts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Amount',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.5,
          ),
          itemCount: amounts.length,
          itemBuilder: (context, index) {
            final amount = amounts[index];
            return Obx(
                  () => GestureDetector(
                onTap: () => controller.selectAmount(amount),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color:
                  controller.selectedAmount.value == amount
                      ? TColors.primary
                      : dark
                      ? TColors.darkerGrey
                      : TColors.lightGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '₦$amount',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: controller.selectedAmount.value == amount
                              ? Colors.white
                              : dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Text(
                        'Pay ₦$amount',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: controller.selectedAmount.value == amount
                              ? Colors.white
                              : dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPurchaseButton(
      ElectricityController controller, BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          'Phone Number (Optional)',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: TextEditingController(text: controller.phoneNumber.value),
          onChanged: (value) => controller.phoneNumber.value = value,
          decoration: InputDecoration(
            hintText: 'Enter phone number for receipt',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: Obx(
                () => ElevatedButton(
              onPressed: controller.isPurchasing.value
                  ? null
                  : () => controller.purchaseElectricity(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: TColors.primary,
              ),
              child: controller.isPurchasing.value
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
                  : const Text(
                'Purchase',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}