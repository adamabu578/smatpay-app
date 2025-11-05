import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

import '../../data/controller/data_controller.dart';
import '../../data_ePin/screen/success_page.dart';

class TTestingSmeDataScreen extends StatefulWidget {
  @override
  _TTestingSmeDataScreenState createState() => _TTestingSmeDataScreenState();
}

class _TTestingSmeDataScreenState extends State<TTestingSmeDataScreen> {
  final DataBundleController bundleController = Get.put(DataBundleController());
  final DataPurchaseController purchaseController =
      Get.put(DataPurchaseController());
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bundleController.fetchDataBundles();
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
      appBar: AppBar(
        title: Text('Buy Data'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Iconsax.message_question),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: dark ? TColors.primary2 : TColors.white,
                  border: Border.all(color: TColors.grey, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Select Network',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(height: 12),
                    _buildNetworkSelector(),
                    SizedBox(height: 20),
                    Text('Select Data Bundle',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(height: 12),
                    _buildBundleSelector(),
                    SizedBox(height: 20),
                    Text('Amount',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(height: 12),
                    _buildAmountDisplay(),
                    SizedBox(height: 20),
                    Text('Phone Number',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(height: 12),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Enter phone number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(Icons.phone),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              _buildPurchaseButton(),
              _buildStatusMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildNetworkButton('mtn', TImages.mtn, 'MTN'),
        _buildNetworkButton('glo', TImages.glo, 'GLO'),
        _buildNetworkButton('airtel', TImages.airtel, 'AIRTEL'),
      ],
    );
  }

  Widget _buildNetworkButton(String network, String image, String label) {
    return Obx(() => GestureDetector(
          onTap: () => bundleController.selectNetwork(network),
          child: Container(
            width: 72,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: (bundleController.selectedNetwork.value ?? '') == network
                    ? TColors.primary
                    : TColors.grey,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
              color: (bundleController.selectedNetwork.value ?? '') == network
                  ? TColors.primary.withOpacity(0.1)
                  : Colors.transparent,
            ),
            child: Column(
              children: [
                Image.asset(image, width: 36, height: 36),
                SizedBox(height: 4),
                Text(label, style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ));
  }

  Widget _buildBundleSelector() {
    return Obx(() {
      if (bundleController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (bundleController.dataBundles.isEmpty) {
        return Text(
          'No bundles available for ${bundleController.selectedNetwork.value.toUpperCase()}',
          style: TextStyle(color: Colors.grey),
        );
      }

      return GestureDetector(
        onTap: () => _showBundleDialog(context),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: TColors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  bundleController.selectedBundle.value != null
                      ? _formatBundleName(bundleController
                              .selectedBundle.value?['name']
                              ?.toString() ??
                          '')
                      : 'Select a data bundle',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Icon(Icons.arrow_drop_down, color: TColors.primary),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildAmountDisplay() {
    return Obx(() {
      final selectedBundle = bundleController.selectedBundle.value;
      final amount = selectedBundle != null
          ? (selectedBundle['variation_amount']?.toString() ?? '0.00')
          : '0.00';

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: TColors.darkerGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text('₦',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: TColors.primary,
                )),
            const SizedBox(width: 4),
            Text(_formatAmount(amount),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      );
    });
  }

  /// Amount
  Widget _buildPurchaseButton() {
    return Obx(() {
      final isLoading = purchaseController.isLoading.value;
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isLoading ? null : _handlePurchase,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            backgroundColor: TColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text('PROCEED TO PAYMENT',
                  style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      );
    });
  }

  Widget _buildStatusMessage() {
    return Obx(() {
      final message = purchaseController.formattedStatus;
      if (message != null) {
        return Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            message,
            style: TextStyle(color: Colors.red),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }

  void _handlePurchase() {
    final selectedBundle = bundleController.selectedBundle.value;
    final selectedNetwork = bundleController.selectedNetwork.value;
    final phone = phoneController.text.trim();

    if (selectedBundle == null) {
      Get.snackbar('Error', 'Please select a data bundle');
      return;
    }

    if (selectedNetwork == null || selectedNetwork.isEmpty) {
      Get.snackbar('Error', 'Please select a network');
      return;
    }

    if (phone.isEmpty) {
      Get.snackbar('Error', 'Please enter phone number');
      return;
    }

    final bundleCode = selectedBundle['variation_code']?.toString() ?? '';
    if (bundleCode.isEmpty) {
      Get.snackbar('Error', 'Invalid or missing bundle code');
      return;
    }

    purchaseController.purchaseData(
      network: selectedNetwork,
      phoneNumber: phone,
      bundleCode: bundleCode,
    );
  }


  void _showBundleDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Select Data Bundle',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: bundleController.dataBundles.length,
                separatorBuilder: (context, index) => Divider(height: 1),
                itemBuilder: (context, index) {
                  final bundle = bundleController.dataBundles[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    title: Text(
                      _formatValidity(bundle['name']),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      '₦${_formatAmount(bundle['variation_amount'])}',
                      style: TextStyle(
                          color: TColors.primary, fontFamily: 'Roboto'),
                    ),
                    onTap: () {
                      bundleController.selectedBundle.value = bundle;
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatBundleName(String name) {
    name = name.replaceAll('  ', ' ');
    if (name.contains('Day')) {
      return name.replaceAll('Day', 'Days').trim();
    }
    return name.trim();
  }

  String _formatValidity(String name) {
    name = name.replaceAll('  ', ' ');
    if (name.contains('Day')) {
      return name.replaceAll('Day', 'Days').trim();
    }
    return name.trim();
  }

  String _formatAmount(dynamic amount) {
    try {
      if (amount == null) return '0.00'; // ✅ Prevent null crash
      final numValue = double.parse(amount.toString());
      return numValue
          .toStringAsFixed(0)
          .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},');
    } catch (e) {
      return amount?.toString() ?? '0.00';
    }
  }

}
