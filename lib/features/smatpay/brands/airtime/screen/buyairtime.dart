import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:smatpay/utils/validators/validation.dart';
import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../controllers/wallet_controller.dart';
import '../controller/airtime_controller.dart';
import 'airtime_success_screen.dart';

class TBuyAirtimeScreen extends StatefulWidget {
  const TBuyAirtimeScreen({super.key});

  @override
  State<TBuyAirtimeScreen> createState() => _TBuyAirtimeScreenState();
}

class _TBuyAirtimeScreenState extends State<TBuyAirtimeScreen> {
  final AirtimeController controller = Get.put(AirtimeController());
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final walletController = Get.put(WalletController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedOperator;
  late Worker _statusWorker;

  // Quick amount options
  final List<String> quickAmounts = ['50', '100', '200', '500', '1000', '2000'];

  @override
  void initState() {
    super.initState();
    _statusWorker = ever(controller.transactionStatus, (status) {
      if (status == 'success') {
        final txnId = controller.transactionId.value;
        final message = controller.transactionMessage.value;
        if (txnId != null && txnId.isNotEmpty) {
          Get.to(
            () => AirtimeSuccessScreen(
              transactionId: txnId,
              message: message.isNotEmpty ? message : 'Airtime purchase successful!',
            ),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            controller.reset();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _statusWorker.dispose();
    phoneController.dispose();
    amountController.dispose();
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
          icon: Icon(Iconsax.arrow_left, color: dark ? TColors.white : TColors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Buy Airtime',
          style: TextStyle(color: dark ? TColors.white : TColors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Iconsax.message_question, color: dark ? TColors.white : TColors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNetworkOption(TImages.mtn, 'MTN', dark),
                    _buildNetworkOption(TImages.airtel, 'Airtel', dark),
                    _buildNetworkOption(TImages.glo, 'Glo', dark),
                    _buildNetworkOption(TImages.ninemobile, '9mobile', dark),
                  ],
                ),

                const SizedBox(height: 28),

                // --- Phone Number ---
                Text(
                  'Phone Number',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: phoneController,
                  validator: TValidator.validatePhoneNumber,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter phone number',
                    prefixIcon: const Icon(Iconsax.call, color: TColors.primary),
                    suffixIcon: IconButton(
                      icon: const Icon(Iconsax.user, color: TColors.primary, size: 20),
                      onPressed: () {
                        // Could open contacts picker
                      },
                    ),
                    filled: true,
                    fillColor: dark ? TColors.primary2 : TColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: dark ? TColors.darkGrey : TColors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: dark ? TColors.darkGrey : TColors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: TColors.primary, width: 1.5),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // --- Amount ---
                Text(
                  'Amount',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter an amount' : null,
                  decoration: InputDecoration(
                    hintText: '0.00',
                    prefixText: '₦ ',
                    prefixStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      color: dark ? TColors.white : TColors.black,
                    ),
                    filled: true,
                    fillColor: dark ? TColors.primary2 : TColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: dark ? TColors.darkGrey : TColors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: dark ? TColors.darkGrey : TColors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: TColors.primary, width: 1.5),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    color: dark ? TColors.white : TColors.black,
                  ),
                ),

                const SizedBox(height: 16),

                // --- Quick Amount Chips ---
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: quickAmounts.map((amount) {
                    final isSelected = amountController.text == amount;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          amountController.text = amount;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? TColors.primary
                              : dark
                                  ? TColors.primary2
                                  : TColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? TColors.primary : (dark ? TColors.darkGrey : TColors.grey),
                          ),
                        ),
                        child: Text(
                          '₦$amount',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: isSelected
                                ? TColors.white
                                : dark
                                    ? TColors.grey
                                    : TColors.darkerGrey,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 32),

                // --- Proceed Button ---
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && selectedOperator != null) {
                        _showConfirmationSheet(context);
                      } else if (selectedOperator == null) {
                        Get.snackbar('Error', 'Please select a network',
                            backgroundColor: Colors.red, colorText: Colors.white);
                      } else {
                        Get.snackbar('Error', 'Please fill all fields correctly',
                            backgroundColor: Colors.red, colorText: Colors.white);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: TColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Obx(() => controller.isLoading.value
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                          )
                        : const Text(
                            'Proceed to Payment',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                          )),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Network Option ────────────────────────────────────────────
  Widget _buildNetworkOption(String image, String label, bool dark) {
    final isSelected = selectedOperator == label;
    return GestureDetector(
      onTap: () => setState(() => selectedOperator = label),
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
            color: isSelected ? TColors.primary : (dark ? TColors.darkGrey : TColors.grey),
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
                color: isSelected ? TColors.primary : (dark ? TColors.grey : TColors.darkerGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Confirmation Bottom Sheet ─────────────────────────────────
  void _showConfirmationSheet(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final operator = selectedOperator!;
    final phone = phoneController.text.trim();
    final amount = amountController.text.trim();

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
                'Confirm Payment',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),

              // Amount
              Text(
                '₦$amount',
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
                    _buildDetailRow(context, 'Network', operator, dark),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: dark ? TColors.darkGrey : TColors.grey, height: 1),
                    ),
                    _buildDetailRow(context, 'Phone Number', phone, dark),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: dark ? TColors.darkGrey : TColors.grey, height: 1),
                    ),
                    _buildDetailRow(context, 'Amount', '₦$amount', dark),
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
                    Text('Wallet', style: Theme.of(context).textTheme.bodyMedium),
                    const Spacer(),
                    Obx(() {
                      if (walletController.isLoading.value) {
                        return const TShimmerEffect(width: 80, height: 18);
                      }
                      return Text(
                        '₦${walletController.balance.value.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
                final isLoading = controller.isLoading.value;
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            Get.back();
                            controller.buyAirtime(
                              operator: operator,
                              phoneNumber: phone,
                              amount: amount,
                            );
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
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            'Confirm Payment',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
                  style: TextStyle(color: dark ? TColors.grey : TColors.darkerGrey),
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

  Widget _buildDetailRow(BuildContext context, String label, String value, bool dark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: dark ? TColors.grey : TColors.darkerGrey,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
