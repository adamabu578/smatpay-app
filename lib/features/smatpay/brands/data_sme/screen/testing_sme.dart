import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../controllers/wallet_controller.dart';
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
  final walletController = Get.put(WalletController());
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bundleController.fetchDataBundles();
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
        backgroundColor: dark ? TColors.secondary : TColors.softGrey,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left,
              color: dark ? TColors.white : TColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Buy Data',
            style: TextStyle(color: dark ? TColors.white : TColors.black)),
        actions: [
          IconButton(
            icon: Icon(Iconsax.message_question,
                color: dark ? TColors.white : TColors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // --- Network Selector ---
              Text(
                'Select Network',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 14),
              _buildNetworkSelector(dark),

              const SizedBox(height: 28),

              // --- Data Bundle Selector ---
              Text(
                'Select Data Bundle',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 10),
              _buildBundleSelector(dark),

              const SizedBox(height: 28),

              // --- Amount Display ---
              Text(
                'Amount',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 10),
              _buildAmountDisplay(dark),

              const SizedBox(height: 28),

              // --- Phone Number ---
              Text(
                'Phone Number',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter phone number',
                  prefixIcon:
                      const Icon(Iconsax.call, color: TColors.primary),
                  suffixIcon: IconButton(
                    icon: const Icon(Iconsax.user,
                        color: TColors.primary, size: 20),
                    onPressed: () {},
                  ),
                  filled: true,
                  fillColor: dark ? TColors.primary2 : TColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                        color: dark ? TColors.darkGrey : TColors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                        color: dark ? TColors.darkGrey : TColors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        const BorderSide(color: TColors.primary, width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // --- Proceed Button ---
              _buildPurchaseButton(dark),
              _buildStatusMessage(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Network Selector ──────────────────────────────────────────
  Widget _buildNetworkSelector(bool dark) {
    return Obx(() {
      final selected = bundleController.selectedNetwork.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNetworkOption('mtn', TImages.mtn, 'MTN', selected, dark),
          _buildNetworkOption('glo', TImages.glo, 'GLO', selected, dark),
          _buildNetworkOption(
              'airtel', TImages.airtel, 'AIRTEL', selected, dark),
          _buildNetworkOption(
              '9mobile', TImages.ninemobile, '9mobile', selected, dark),
        ],
      );
    });
  }

  Widget _buildNetworkOption(String network, String image, String label,
      String selected, bool dark) {
    final isSelected = selected == network;
    return GestureDetector(
      onTap: () => bundleController.selectNetwork(network),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 76,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? TColors.primary.withValues(alpha: 0.1)
              : dark
                  ? TColors.primary2
                  : TColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? TColors.primary
                : (dark ? TColors.darkGrey : TColors.grey),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Image.asset(image, width: 40, height: 40),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? TColors.primary
                    : (dark ? TColors.grey : TColors.darkerGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Bundle Selector ───────────────────────────────────────────
  Widget _buildBundleSelector(bool dark) {
    return Obx(() {
      if (bundleController.isLoading.value) {
        return Container(
          height: 52,
          decoration: BoxDecoration(
            color: dark ? TColors.primary2 : TColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: dark ? TColors.darkGrey : TColors.grey),
          ),
          child: const Center(
            child: SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                  strokeWidth: 2.5, color: TColors.primary),
            ),
          ),
        );
      }

      if (bundleController.dataBundles.isEmpty) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: dark ? TColors.primary2 : TColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: dark ? TColors.darkGrey : TColors.grey),
          ),
          child: Text(
            'No bundles available for ${bundleController.selectedNetwork.value.toUpperCase()}',
            style: TextStyle(
                color: dark ? TColors.grey : TColors.darkerGrey, fontSize: 13),
          ),
        );
      }

      return GestureDetector(
        onTap: () => _showBundleDialog(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: dark ? TColors.primary2 : TColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: dark ? TColors.darkGrey : TColors.grey),
          ),
          child: Row(
            children: [
              Icon(Iconsax.wifi, size: 20, color: TColors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  bundleController.selectedBundle.value != null
                      ? _formatBundleName(bundleController
                              .selectedBundle.value?['name']
                              ?.toString() ??
                          '')
                      : 'Tap to select a bundle',
                  style: TextStyle(
                    fontSize: 14,
                    color: bundleController.selectedBundle.value != null
                        ? (dark ? TColors.white : TColors.black)
                        : (dark ? TColors.grey : TColors.darkerGrey),
                  ),
                ),
              ),
              Icon(Iconsax.arrow_down_1,
                  size: 18, color: dark ? TColors.grey : TColors.darkerGrey),
            ],
          ),
        ),
      );
    });
  }

  // ─── Amount Display ────────────────────────────────────────────
  Widget _buildAmountDisplay(bool dark) {
    return Obx(() {
      final selectedBundle = bundleController.selectedBundle.value;
      final amount = selectedBundle != null
          ? (selectedBundle['variation_amount']?.toString() ??
              selectedBundle['amount']?.toString() ??
              selectedBundle['price']?.toString() ??
              '0.00')
          : '0.00';

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: dark ? TColors.primary2 : TColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: dark ? TColors.darkGrey : TColors.grey),
        ),
        child: Row(
          children: [
            Text(
              '₦',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: TColors.primary,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              _formatAmount(amount),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: dark ? TColors.white : TColors.black,
              ),
            ),
          ],
        ),
      );
    });
  }

  // ─── Purchase Button ───────────────────────────────────────────
  Widget _buildPurchaseButton(bool dark) {
    return Obx(() {
      final isLoading = purchaseController.isLoading.value;
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isLoading
              ? null
              : () async {
                  try {
                    await _handlePurchase();
                  } catch (e) {
                    Get.snackbar('Error', 'An error occurred: $e');
                  }
                },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: TColors.primary,
            disabledBackgroundColor: TColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2.5),
                )
              : const Text(
                  'Proceed to Payment',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
        ),
      );
    });
  }

  Widget _buildStatusMessage() {
    return Obx(() {
      final message = purchaseController.formattedStatus;
      if (message != null) {
        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(message,
                      style: const TextStyle(color: Colors.red, fontSize: 13)),
                ),
              ],
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }

  // ─── Handle Purchase ───────────────────────────────────────────
  Future<void> _handlePurchase() async {
    final selectedBundle = bundleController.selectedBundle.value;
    final selectedNetwork = bundleController.selectedNetwork.value;
    final phone = phoneController.text.trim();

    if (selectedBundle == null) {
      Get.snackbar('Error', 'Please select a data bundle');
      return;
    }
    if (selectedNetwork.isEmpty) {
      Get.snackbar('Error', 'Please select a network');
      return;
    }
    if (phone.isEmpty) {
      Get.snackbar('Error', 'Please enter phone number');
      return;
    }

    final bundleCode = selectedBundle['code']?.toString() ??
        selectedBundle['variation_code']?.toString() ??
        '';
    if (bundleCode.isEmpty) {
      Get.snackbar('Error', 'Invalid or missing bundle code');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'You are not authenticated. Please log in.');
      return;
    }

    final amount = selectedBundle['variation_amount']?.toString() ??
        selectedBundle['amount']?.toString() ??
        '0';

    // Show confirmation sheet
    _showConfirmationSheet(
      context,
      network: selectedNetwork,
      phone: phone,
      bundleCode: bundleCode,
      bundleName: _formatBundleName(selectedBundle['name']?.toString() ?? ''),
      amount: amount,
    );
  }

  // ─── Confirmation Bottom Sheet ─────────────────────────────────
  void _showConfirmationSheet(
    BuildContext context, {
    required String network,
    required String phone,
    required String bundleCode,
    required String bundleName,
    required String amount,
  }) {
    final dark = THelperFunctions.isDarkMode(context);

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: dark ? TColors.primary2 : TColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: dark ? TColors.darkGrey : TColors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                'Confirm Purchase',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),

              // Amount
              Text(
                '₦${_formatAmount(amount)}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      color: TColors.primary,
                    ),
              ),
              const SizedBox(height: 24),

              // Details card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: dark ? TColors.secondary : TColors.softGrey,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(context, 'Network', network.toUpperCase(), dark),
                    _divider(dark),
                    _buildDetailRow(context, 'Bundle', bundleName, dark),
                    _divider(dark),
                    _buildDetailRow(context, 'Phone', phone, dark),
                    _divider(dark),
                    _buildDetailRow(
                        context, 'Amount', '₦${_formatAmount(amount)}', dark),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Wallet balance
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: dark ? TColors.secondary : TColors.softGrey,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Icon(Iconsax.wallet_3, color: TColors.primary, size: 22),
                    const SizedBox(width: 12),
                    Text('Wallet',
                        style: Theme.of(context).textTheme.bodyMedium),
                    const Spacer(),
                    Obx(() {
                      if (walletController.isLoading.value) {
                        return const TShimmerEffect(width: 80, height: 18);
                      }
                      return Text(
                        '₦${walletController.balance.value.toStringAsFixed(2)}',
                        style:
                            Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Confirm button
              Obx(() {
                final isLoading = purchaseController.isLoading.value;
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            Get.back();
                            await purchaseController.purchaseData(
                              network: network,
                              phoneNumber: phone,
                              bundleCode: bundleCode,
                            );
                            if (purchaseController.transactionStatus.value ==
                                'success') {
                              Get.offAll(() => TSuccessPage(
                                    transactionId: purchaseController
                                            .transactionId.value ??
                                        'N/A',
                                    message: 'Data purchase successful!',
                                  ));
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: TColors.primary,
                      disabledBackgroundColor: TColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2.5),
                          )
                        : const Text(
                            'Confirm Payment',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                  ),
                );
              }),
              const SizedBox(height: 8),

              // Cancel
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: dark ? TColors.grey : TColors.darkerGrey),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildDetailRow(
      BuildContext context, String label, String value, bool dark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: dark ? TColors.grey : TColors.darkerGrey,
              ),
        ),
        Flexible(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _divider(bool dark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child:
          Divider(color: dark ? TColors.darkGrey : TColors.grey, height: 1),
    );
  }

  // ─── Bundle Bottom Sheet ───────────────────────────────────────
  void _showBundleDialog(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: dark ? TColors.primary2 : TColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: dark ? TColors.darkGrey : TColors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text('Select Data Bundle',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: bundleController.dataBundles.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: dark ? TColors.darkGrey : TColors.grey,
                ),
                itemBuilder: (context, index) {
                  final bundle = bundleController.dataBundles[index];
                  final isSelected =
                      bundleController.selectedBundle.value?['code'] ==
                          bundle['code'];
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? TColors.primary.withValues(alpha: 0.1)
                            : (dark ? TColors.secondary : TColors.softGrey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Iconsax.wifi,
                          size: 20,
                          color:
                              isSelected ? TColors.primary : TColors.darkGrey),
                    ),
                    title: Text(
                      _formatBundleName(bundle['name']),
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      '₦${_formatAmount(bundle['amount'] ?? bundle['variation_amount'])}',
                      style: const TextStyle(
                          color: TColors.primary,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: isSelected
                        ? const Icon(Iconsax.tick_circle,
                            color: TColors.primary, size: 20)
                        : null,
                    onTap: () {
                      bundleController.selectedBundle.value =
                          Map<String, dynamic>.from(bundle);
                      bundleController.selectedBundle.refresh();
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

  // ─── Helpers ───────────────────────────────────────────────────
  String _formatBundleName(String name) {
    name = name.replaceAll('  ', ' ');
    if (name.contains('Day')) {
      return name.replaceAll('Day', 'Days').trim();
    }
    return name.trim();
  }

  String _formatAmount(dynamic amount) {
    try {
      if (amount == null) return '0.00';
      final numValue = double.parse(amount.toString());
      return numValue.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    } catch (e) {
      return amount?.toString() ?? '0.00';
    }
  }
}
