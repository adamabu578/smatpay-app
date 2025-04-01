import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../data/controller/data_controller.dart';
import '../../data_ePin/screen/success_page.dart';

class TTestingSmeDataScreen extends StatefulWidget {
  @override
  _TTestingSmeDataScreenState createState() => _TTestingSmeDataScreenState();
}

class _TTestingSmeDataScreenState extends State<TTestingSmeDataScreen> {
  final DataBundleController bundleController = Get.put(DataBundleController());
  final DataPurchaseController purchaseController = Get.put(DataPurchaseController());
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bundleController.fetchDataBundles();

    // Listen to purchase status changes
    ever(purchaseController.transactionStatus, (status) {
      if (status == 'success') {
        Get.offAll(() => TSuccessPage(
          transactionId: purchaseController.transactionId.value!,
          message: 'Data purchase successful!',
        ));
      }
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Buy Data'),
        showBackArrow: true,
        actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Container(
                width: double.infinity,
                height: 480,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: dark ? TColors.primary2 : TColors.white,
                  border: Border.all(color: TColors.grey, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select Network'),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNetworkButton('mtn', TImages.mtn, 'MTN'),
                          _buildNetworkButton('glo', TImages.glo, 'GLO'),
                          _buildNetworkButton('airtel', TImages.airtel, 'AIRTEL'),
                        ],
                      ),
                      SizedBox(height: 25),

                      Text('Select Data Bundle'),
                      SizedBox(height: 20),
                      Obx(() => _buildBundleDropdown()),

                      SizedBox(height: 20),

                      Text('Amount'),
                      SizedBox(height: 10),
                      Obx(() {
                        final amount = bundleController.selectedBundle.value != null
                            ? bundleController.selectedBundle.value!['variation_amount']
                            : '0';

                        return RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headlineSmall,
                            children: [
                              TextSpan(
                                text: '₦ ',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  // Keep other styles from headlineSmall
                                  fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                                  fontWeight: Theme.of(context).textTheme.headlineSmall?.fontWeight,
                                  color: Theme.of(context).textTheme.headlineSmall?.color,
                                ),
                              ),
                              TextSpan(
                                text: amount,
                                // Use the original style for the amount
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        );
                      }),

                      SizedBox(height: 20),

                      Text('Phone Number'),
                      SizedBox(height: 10),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Enter phone number',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildPurchaseButton(),
              Obx(() => _buildStatusMessage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBundleDropdown() {
    if (bundleController.isLoading.value) {
      return Center(child: CircularProgressIndicator());
    }

    if (bundleController.dataBundles.isEmpty) {
      return Text(
        'No bundles available for ${bundleController.selectedNetwork.value}',
        style: TextStyle(color: Colors.grey),
      );
    }

    return DropdownButton<Map<String, dynamic>>(
      value: bundleController.selectedBundle.value,
      isExpanded: true,
      hint: Text('Select a data bundle'),
      items: bundleController.dataBundles.map((bundle) {
        return DropdownMenuItem(
          value: bundle,
          child: Text(bundle['name']),
        );
      }).toList(),
      onChanged: (bundle) {
        bundleController.selectedBundle.value = bundle;
      },
    );
  }

  Widget _buildPurchaseButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(() {
        final isLoading = purchaseController.isLoading.value;
        return ElevatedButton(
          onPressed: isLoading ? null : _handlePurchase,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            backgroundColor: isLoading ? Colors.grey : TColors.primary,
          ),
          child: isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text('PROCEED TO PAYMENT'),
        );
      }),
    );
  }

  void _handlePurchase() {
    // Validate inputs
    if (bundleController.selectedBundle.value == null) {
      Get.snackbar('Error', 'Please select a data bundle');
      return;
    }

    if (phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter phone number');
      return;
    }

    // Proceed with purchase
    purchaseController.purchaseData(
      network: bundleController.selectedNetwork.value,
      phoneNumber: phoneController.text,
      bundleCode: bundleController.selectedBundle.value!['variation_code'],
    );
  }

  Widget _buildStatusMessage() {
    final status = purchaseController.transactionStatus.value;
    if (status == 'insufficient_balance') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          'Insufficient balance',
          style: TextStyle(color: Colors.red),
        ),
      );
    }
    return SizedBox();
  }

  Widget _buildNetworkButton(String network, String image, String label) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => bundleController.selectNetwork(network),
      child: Obx(() => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: bundleController.selectedNetwork.value == network
                ? Colors.blue
                : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
          color: bundleController.selectedNetwork.value == network
              ? Colors.blue.withOpacity(0.1)
              : Colors.transparent,
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Image.asset(image, width: 60, height: 60),
            Text(label),
          ],
        ),
      )),
    );
  }
}