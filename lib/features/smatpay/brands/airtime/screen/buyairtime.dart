import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:smatpay/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TBuyAirtimeScreen extends StatefulWidget {
  const TBuyAirtimeScreen({super.key});

  @override
  State<TBuyAirtimeScreen> createState() => _TBuyAirtimeScreenState();
}

class _TBuyAirtimeScreenState extends State<TBuyAirtimeScreen> {
  //String? selectedDataPlan;
  String? selectedOperator;
  // String? selectedAmount;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Container(
                width: double.infinity,
                height: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: dark ? TColors.primary2 : TColors.white,
                  border: Border.all(
                    color: TColors.grey, // Specify the border color
                    width: 1, // Specify the border width
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Mobile Operator',
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: dark ? TColors.white : TColors.black,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOperator =
                                    'Airtel'; // Changes the selected operator to 'Airtel'
                                //   selectedDataPlan =
                                null; // Resets the selected data plan to null
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedOperator == 'Airtel'
                                      ? TColors.primary
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                TImages.airtel,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOperator = 'Glo';
                                //     selectedDataPlan = null;
                                //     selectedAmount = null;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedOperator == 'Glo'
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                TImages.glo,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOperator = 'MTN';
                                //    selectedDataPlan = null;
                                //     selectedAmount = null;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedOperator == 'MTN'
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                TImages.mtn,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOperator = '9mobile';
                                //       selectedDataPlan = null;
                                //       selectedAmount = null;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedOperator == '9mobile'
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                TImages.ninemobile,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      /// Phone No
                      Text(
                        'Phone Number',
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: dark ? TColors.white : TColors.black,
                            ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) =>
                            TValidator.validatePhoneNumber(value),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.call),
                          labelText: TTexts.phoneNo,
                          labelStyle: TextStyle(
                            color: dark ? TColors.light : TColors.black,
                          ),
                          prefixIconColor: TColors.primary,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),

                      /// Amount
                      Text(
                        'Amount',
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: dark ? TColors.white : TColors.black,
                            ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.money),
                          labelText: 'Input Amount',
                          labelStyle: TextStyle(
                            color: dark ? TColors.light : TColors.black,
                          ),
                          prefixIconColor: TColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    //  => controller.signup(),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(TSizes.md),
                        backgroundColor: TColors.primary,
                        side: const BorderSide(
                          color: TColors.primary,
                        )),
                    child: const Text('Proceed to payment')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
