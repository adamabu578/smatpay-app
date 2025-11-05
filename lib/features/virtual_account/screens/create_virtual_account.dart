import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/virtual_account/controllers/create_virtual_account_controller.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class CreateVirtualAccountScreen extends StatelessWidget {
  const CreateVirtualAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateVirtualAccountController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Create Virtual Account',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() => SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.isLoading.value
                ? null
                : () async {
              await controller.createVirtualAccount();
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
      ),
    );
  }
}
