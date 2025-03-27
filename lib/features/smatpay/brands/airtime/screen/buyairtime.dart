import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:smatpay/utils/validators/validation.dart';
import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../controllers/wallet_controller.dart';
import '../controller/airtime_controller.dart';

class TBuyAirtimeScreen extends StatefulWidget {
  const TBuyAirtimeScreen({super.key});

  @override
  State<TBuyAirtimeScreen> createState() => _TBuyAirtimeScreenState();
}

class _TBuyAirtimeScreenState extends State<TBuyAirtimeScreen> {
  final AirtimeController controller = Get.put(AirtimeController());
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final walletController = Get.put(WalletController()); //

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedOperator;


    void showConfirmationBottomSheet(BuildContext context, AirtimeController controller, String operator, String phone, String amount) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.7, // Ensures it takes 60% of the screen height
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: SingleChildScrollView( // 🔥 Wraps content in scrollable view to prevent overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // 👈 Important to let the content determine its size
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Payment",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close, color: Colors.black54),
                  ),
                ],
              ),


              const SizedBox(height: 10),

              // Payment Amount
              Center(
                child: Text(
                  "₦$amount",
                  style: const TextStyle(fontSize: 26, fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
              ),
              const SizedBox(height: 15),
              const Divider(),

              // Payment Details
              ListTile(
                leading: const Icon(Icons.sim_card, color: Colors.deepPurple),
                title: const Text("Amount", style: const TextStyle(color: Colors.black38)),
                trailing: Text("₦$amount", style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto', color: Colors.black)),
              ),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet, color: Colors.blue),
                title: const Text("Provider", style: const TextStyle(color: Colors.black38)),
                trailing: Text(operator, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: const Text("Mobile number", style: const TextStyle(color: Colors.black38)),
                trailing: Text(phone, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              const SizedBox(height: 10),

              // Payment Method
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Payment Method", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
                  TextButton(onPressed: () {}, child: const Text("All >", style: TextStyle(color: Colors.deepPurple))),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance_wallet, color: Colors.black),
                    const SizedBox(width: 10),
                    Obx(() {
                      if (walletController.isLoading.value) {
                        return const TShimmerEffect(width: 100, height: 20);
                      }
                      return Text(
                        walletController.showBalance.value
                            ? '₦${walletController.balance.value.toStringAsFixed(2)}'
                            : '****',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: TColors.black, fontFamily: 'Roboto', fontWeight: FontWeight.bold),
                      );
                    }),

                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Add Money", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(Icons.add_circle, color: Colors.blue),
                    const SizedBox(width: 10),
                    const Text("Use new bank card/bank account", style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Earn Points
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Earn", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text("+3Pts", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 10), // Space before button

              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    controller.buyAirtime(operator: operator, phoneNumber: phone, amount: amount);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Confirm to Pay', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true, // ✅ Ensures full height adjustment on different screen sizes
    );
  }





  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Buy Airtime'),
        showBackArrow: true,
        actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey, // ✅ Wrap fields in Form widget
            child: Column(
              children: [
                const SizedBox(height: 60),
                Container(
                  width: double.infinity,
                  height: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: dark ? TColors.primary2 : TColors.white,
                    border: Border.all(color: TColors.grey, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Select Mobile Operator',
                            style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: dark ? TColors.white : TColors.black,
                            )),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            operatorButton(TImages.airtel, 'Airtel'),
                            operatorButton(TImages.glo, 'Glo'),
                            operatorButton(TImages.mtn, 'MTN'),
                            operatorButton(TImages.ninemobile, '9mobile'),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        Text('Phone Number',
                            style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: dark ? TColors.white : TColors.black,
                            )),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: phoneController,
                          validator: TValidator.validatePhoneNumber,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.call),
                            labelText: TTexts.phoneNo,
                            prefixIconColor: TColors.primary,
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        Text('Amount',
                            style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: dark ? TColors.white : TColors.black,
                            )),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter an amount' : null,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.money),
                            labelText: 'Input Amount',
                            prefixIconColor: TColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && selectedOperator != null) {
                        showConfirmationBottomSheet(
                          context,
                          controller,
                          selectedOperator!,
                          phoneController.text.trim(),
                          amountController.text.trim(),
                        );
                      } else {
                        Get.snackbar('Error', 'Please fill all fields correctly',
                            backgroundColor: Colors.red, colorText: Colors.white);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(TSizes.md),
                      backgroundColor: TColors.primary,
                      side: const BorderSide(color: TColors.primary),
                    ),
                    child: Obx(() => controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Proceed to payment')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget operatorButton(String image, String operator) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedOperator = operator);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedOperator == operator ? TColors.primary : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(image),
      ),
    );
  }
}

