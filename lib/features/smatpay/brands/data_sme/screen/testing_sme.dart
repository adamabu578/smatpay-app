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
    phoneController.addListener(() {
      print('Phone Number Updated: ${phoneController.text}');
      bundleController.phoneNumber.value = phoneController.text;
    });

    // Listen to purchase status changes
    ever(purchaseController.transactionStatus, (status) {
      if (status == 'success') {
        Get.to(() => TSuccessPage(
          transactionId: purchaseController.transactionId.value!,
          message: 'Data purchase successful!',
        ));
      }
    });
  }

  //   // Listen to phone number changes
  //   phoneController.addListener(() {
  //     bundleController.phoneNumber.value = phoneController.text;
  //   });
  // }

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

      // ... your existing scaffold code
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
                // ... your container decoration
                child: Container(
                  width: double.infinity,
                  height: 380,
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
                        // Network selection - No need for Obx here
                        Text('Select Network'),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildNetworkButton('mtn', TImages.mtn, 'MTN'),
                            _buildNetworkButton('glo', TImages.glo, 'GLO'),
                            _buildNetworkButton(
                                'airtel', TImages.airtel, 'AIRTEL'),
                          ],
                        ),
                        SizedBox(height: 25),

                        // Data bundle selection - Only wrap dropdown in Obx
                        Text('Select Data Bundle'),
                        SizedBox(height: 20),
                        Obx(() {
                          if (bundleController.isLoading.value) {
                            return Center(child: CircularProgressIndicator());
                          }

                          // Show empty state if no bundles
                          if (bundleController.dataBundles.isEmpty) {
                            return Text(
                                'No bundles available for ${bundleController.selectedNetwork.value}',
                              style: TextStyle(color: Colors.grey),
                            );

                          }

                          // Ensure selectedBundle exists in current network's bundles
                          final isValidSelection =
                              bundleController.selectedBundle.value != null &&
                                  bundleController.dataBundles.any((b) =>
                                      b['variation_code'] ==
                                      bundleController.selectedBundle
                                          .value!['variation_code']);

                          return DropdownButton<Map<String, dynamic>>(
                            underline: Container(height: 1, color: Colors.grey),
                            icon: Icon(Icons.arrow_drop_down),
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            value: bundleController.selectedBundle.value,
                            isExpanded: true,
                            hint: Text('Select a data bundle'),
                            items: bundleController.dataBundles.map((bundle) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: bundle,
                                child: Text(bundle['name']),
                              );
                            }).toList(),
                            onChanged: (bundle) {
                              if (bundle != null) {
                                print('Selected bundle: ${bundle['name']}');
                                bundleController.selectedBundle.value = bundle;
                              }
                            },
                          );
                        }),
                        SizedBox(height: 20),

                        // Amount display - Only wrap Text in Obx
                        Text('Amount'),
                        SizedBox(height: 10),
                        Obx(() => Text(
                              bundleController.selectedBundle.value != null
                                  ? '₦ ${bundleController.selectedBundle.value!['variation_amount']}'
                                  : '₦ 0',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .apply(
                                    color: dark ? TColors.white : TColors.black,
                                    fontFamily: 'NotoSans',
                                  ),
                            )),
                        // ... rest of your code
                      ],
                    ),
                  ),
                ),
              ),
              _buildPurchaseButton(),
              Obx(() {
                if (purchaseController.transactionStatus.value == 'insufficient_balance') {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Insufficient balance',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPurchaseButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        final isReady = bundleController.selectedBundle.value != null &&
            phoneController.text.isNotEmpty &&
            !purchaseController.isLoading.value;

        print('Button State - Ready: $isReady');
        print('Selected Bundle: ${bundleController.selectedBundle.value != null}');
        print('Phone Number: ${phoneController.text.isNotEmpty}');
        print('Loading State: ${purchaseController.isLoading.value}');

        return ElevatedButton(
          onPressed: isReady ? _handlePurchase : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: TColors.primary,
          ),
          child: purchaseController.isLoading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('PROCEED TO PAYMENT', style: TextStyle(color: Colors.black),),
        );
      }),
    );
  }

  void _handlePurchase() {
    print('Purchase button pressed'); // Debug print

    // Debug print selected bundle details
    print('Selected Bundle Details: ${bundleController.selectedBundleDetails}');
    print('Phone Number: ${phoneController.text}');

    if (bundleController.selectedBundleDetails == null) {
      print('Error: No bundle selected');
      Get.snackbar('Error', 'Please select a data bundle');
      return;
    }

    if (phoneController.text.isEmpty) {
      print('Error: No phone number entered');
      Get.snackbar('Error', 'Please enter phone number');
      return;
    }

    print('Proceeding with purchase...');
    print('Network: ${bundleController.selectedNetworkType}');
    print('Bundle Code: ${bundleController.selectedBundleDetails!['variation_code']}');

    purchaseController.purchaseData(
      network: bundleController.selectedNetworkType,
      phoneNumber: phoneController.text,
      bundleCode: bundleController.selectedBundleDetails!['variation_code'],
    );
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
