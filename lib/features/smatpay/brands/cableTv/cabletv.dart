import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/smatpay/brands/airtime/widgets/savebeneficiary.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TCableTvScreen extends StatefulWidget {
  const TCableTvScreen({super.key});

  @override
  State<TCableTvScreen> createState() => _TCableTvScreenState();
}

class _TCableTvScreenState extends State<TCableTvScreen> {
  String? selectedCableProvider;
  String? selectedOperator;
  String? selectedAmount;
  List<String> amountsList = [];
  TextEditingController amountController = TextEditingController();

  final Map<String, List<String>> dataPlans = {
    'Startimes': [
      'Startimes - DTT_Nova',
      'Startimes - DTT_Basic',
      'Startimes - DTT_Classic',
      'Startimes - DTH_Chinese',
      'Startimes - DTH_Global',
      'Startimes - DTH_Basic',
      'Startimes - DTH_Super',
      'Startimes - DTH_Nova',
      'Startimes - DTH_Classic',
      'Startimes - DTT_Super',
      'Startimes - Combo_Basic',
      'Startimes - Combo_Classic',
      'Startimes - Combo_Super',
    ],
    'DStv': [
      'DStv - Premium',
      'DStv - Compact Plus',
      'DStv - Compact',
      'DStv - Confam',
      'DStv - Yanga',
      'DStv - Asian',
      'DStv - Premium + Xtraview',
      'DStv - PremiumAsia',
      'DStv - PremiumAsia + Xtraview',
      'DStv - Premium + French',
      'DStv - Premium + French + Xtraview',
      'DStv - CompactPlus + Asia',
      'DStv - CompactPlus + Asia + Xtraview',
      'DStv - CompactPlus + French Touch',
      'DStv - CompactPlus + French Plus + Xtraview',
      'DStv - Compact + Xtraview',
      'DStv - Compact + French Touch + Xtraview',
      'DStv - Compact + Asia + Xtraview',
      'DStv - Compact + French Plus',
      'DStv - Confam + Xtraview',
      'DStv - Yanga +  Xtraview',
      'DStv - Padi +  Xtraview',
      'HDPVR Access Service',
      'DStv French Plus Add-on Bouquet E36',
      'DStv Asian Add-on Bouquest E36',
      'DStv French Touch Add-on Bouquet E36',
      'DStv Xtraview Access',
      'DStv Great Wall standalone Bouquet',
      'DStv French 11 Bouquet E36',
      'DStv PremiumAsia Showmax',
      'DStv PremiumFrench + Showmax',
      'DStv Premium + Showmax',
      'DStv Asia Showmax',
      'DStv CompactPlus + Showmax',
      'DStv Compact + Showmax',
      'DStv Confam + Showmax',
      'DStv Yanga + Showmax',
      'DStv Padi + Showmax',
    ],
    'GOtv': [
      'GOtv Supa',
      'GOtv Max',
      'GOtv Jolli',
      'GOtv Jinja',
      'GOtv Lite',
      'GOtv Lite(Quarterly)',
      'GOtv Lite(Annual)',
      'GOtv Lite(Supa Plus)',
    ],
    // '9mobile': [
    //   '9mobile - DATA 500MB',
    //   '9mobile - DATA 1GB',
    //   '9mobile - DATA 2GB',
    //   '9mobile - DATA 3GB',
    //   '9mobile - DATA 5GB',
    //   '9mobile - DATA 10GB',
    // ],
  };

  final Map<String, List<String>> amountLists = {
    'Startimes - DTT_Nova': ['N1,700'],
    'Startimes - DTT_Basic': ['N3,300'],
    'Startimes - DTT_Classic': ['N5,000'],
    'Startimes - DTH_Chinese': ['N16,000'],
    'Startimes - DTH_Global': ['N17,000'],
    'Startimes - DTH_Basic': ['N4,200'],
    'Startimes - DTH_Super': ['N8,200'],
    'Startimes - DTH_Nova': ['N1,700'],
    'Startimes - DTH_Classic': ['N6,200'],
    'Startimes - DTT_Super': ['N8,000'],
    'Startimes - Combo_Basic': ['N4,200'],
    'Startimes - Combo_Classic': ['N6,200'],
    'Startimes - Combo_Super': ['N8,200'],
    'DStv - Premium': ['N37,000'],
    'DStv - Compact Plus': ['N25,000'],
    'DStv - Compact': ['N15,700'],
    'DStv - Confam': ['N9,300'],
    'DStv - Yanga': ['N5,100'],
    'DStv - Asian': ['N3,600'],
    'DStv - Premium + Xtraview': ['N12,400'],
    'DStv - PremiumAsia': ['N42,000'],
    'DStv - PremiumAsia + Xtraview': ['N47,000'],
    'DStv - Premium + French': ['N57,500'],
    'DStv - Premium + French + Xtraview': ['N62,500'],
    'DStv - CompactPlus + Asia': ['N37,400'],
    'DStv - CompactPlus + Asia + Xtraview': ['N42,400'],
    'DStv - CompactPlus + French Touch': ['N30,800'],
    'DStv - CompactPlus + French Plus + Xtraview': ['N50,500'],
    'DStv - Compact + Xtraview': ['N30,000'],
    'DStv - Compact + French Touch + Xtraview': ['N28,100'],
    'DStv - Compact + Asia + Xtraview': ['N21,500'],
    'DStv - Compact + French Plus': ['N20,700'],
    'DStv - Confam + Xtraview': ['N26,500'],
    'DStv - Yanga +  Xtraview': ['N33,100'],
    'DStv - Padi +  Xtraview': ['N36,200'],
    'HDPVR Access Service': ['N14,300'],
    'DStv French Plus Add-on Bouquet E36': ['N10,100'],
    'DStv Asian Add-on Bouquest E36': ['N8,600'],
    'DStv French Touch Add-on Bouquet E36': ['N5,000'],
    'DStv Xtraview Access': ['N5,000'],
    'DStv Great Wall standalone Bouquet': ['N3,125'],
    'DStv French 11 Bouquet E36': ['N9,000'],
    'DStv PremiumAsia Showmax': ['N42,000'],
    'DStv PremiumFrench + Showmax': ['N57,500'],
    'DStv Premium + Showmax': ['N37,000'],
    'DStv Asia Showmax': ['N14,900'],
    'DStv CompactPlus + Showmax': ['N26,450'],
    'DStv Compact + Showmax': ['N17,150'],
    'DStv Confam + Showmax': ['N10,750'],
    'DStv Yanga + Showmax': ['N6,550'],
    'DStv Padi + Showmax': ['N6,100'],
    'GOtv Supa': ['N9,600'],
    'GOtv Max': ['N7,200'],
    'GOtv Jolli': ['N4,850'],
    'GOtv Jinja': ['N3,300'],
    'GOtv Lite': ['N1,575'],
    'GOtv Lite(Quarterly)': ['N4,175'],
    'GOtv Lite(Annual)': ['N12,300'],
    'GOtv Lite(Supa Plus)': ['N15,700'],
    // '9mobile - DATA 500MB': ['N120'],
    // '9mobile - DATA 1GB': ['N240'],
    // '9mobile - DATA 2GB': ['N480'],
    // '9mobile - DATA 3GB': ['N720'],
    // '9mobile - DATA 5GB': ['N1200'],
    // '9mobile - DATA 10GB': ['N2400'],
  };

  @override
  void initState() {
    super.initState();
    amountController.text = selectedAmount ?? '';
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    List<String> filteredDataPlans =
        selectedOperator != null ? dataPlans[selectedOperator]! : [];

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Cable TV'),
        showBackArrow: true,
        actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 670,
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
                        'Select provider',
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
                                    'DStv'; // Changes the selected operator to 'Airtel'
                                selectedCableProvider =
                                    null; // Resets the selected data plan to null
                                selectedAmount =
                                    null; // Resets the selected amount to null
                                amountsList = amountLists[
                                    'DStv - Premium']!; // Sets amountsList to the list of amounts for 'Airtel - DATA 500MB'
                                amountController.text = selectedAmount ??
                                    ''; // Updates the amountController's text to the selected amount or empty string
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedOperator == 'DStv'
                                      ? TColors.primary
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                TImages.dstv,
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOperator = 'GOtv';
                                selectedCableProvider = null;
                                selectedAmount = null;
                                amountsList = amountLists['GOtv Supa']!;
                                amountController.text = selectedAmount ?? '';
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedOperator == 'GOtv'
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                TImages.gotv2,
                                width: 69,
                                height: 69,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOperator = 'Startimes';
                                selectedCableProvider = null;
                                selectedAmount = null;
                                amountsList =
                                    amountLists['Startimes - DTT_Nova']!;
                                amountController.text = selectedAmount ?? '';
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedOperator == 'Startimes'
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                TImages.startimes,
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     setState(() {
                          //       selectedOperator = '9mobile';
                          //       selectedCableProvider = null;
                          //       selectedAmount = null;
                          //       amountsList =
                          //           amountLists['9mobile - DATA 500MB']!;
                          //       amountController.text = selectedAmount ?? '';
                          //     });
                          //   },
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       border: Border.all(
                          //         color: selectedOperator == '9mobile'
                          //             ? Colors.blue
                          //             : Colors.transparent,
                          //         width: 2,
                          //       ),
                          //       borderRadius: BorderRadius.circular(8),
                          //     ),
                          //     child: Image.asset(
                          //       TImages.ninemobile,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      /// Amount
                      Text(
                        'Smartcard Number',
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
                          labelText: 'Enter smartcard number',
                          labelStyle: TextStyle(
                            color: dark ? TColors.light : TColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Amount
                          Text(
                            ' Barry E Barry',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(
                                  color: dark ? TColors.white : TColors.black,
                                ),
                          ),
                          Row(
                            children: [
                              /// Amount
                              Text(
                                'Beneficiary',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                      color:
                                          dark ? TColors.white : TColors.black,
                                    ),
                              ),
                              const Icon(Icons.arrow_right)
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      Text(
                        'Subscription Period',
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: dark ? TColors.white : TColors.black,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 253, 243, 255),
                          border: Border.all(
                            color: TColors.primary, // Specify the border color
                            width: 1, // Specify the border width
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '30 Days',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(color: TColors.primary),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      Text(
                        'Select Package',
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: dark ? TColors.white : TColors.black,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        isExpanded: true, //Adding this property, does the magic
                        hint: const Text('Select Plan'),
                        value: selectedCableProvider,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCableProvider = newValue;
                            selectedAmount = amountLists[newValue!]![
                                0]; // Set first amount by default
                            amountsList = amountLists[newValue]!;
                            amountController.text = selectedAmount ?? '';
                          });
                        },
                        items: filteredDataPlans.map((String dataPlan) {
                          return DropdownMenuItem<String>(
                            value: dataPlan,
                            child: Text(dataPlan,
                                softWrap: true,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                      color:
                                          dark ? TColors.white : TColors.black,
                                    ),
                                overflow: TextOverflow.ellipsis),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),
                      TextFormField(
                        controller: amountController,
                        enabled: false,
                        style: TextStyle(
                          // Style for selected amount text
                          fontSize: 18, // Increase font size
                          color: dark
                              ? TColors.light
                              : TColors.black, // Set text color
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.money),
                          labelText: 'Selected Amount',
                          labelStyle: TextStyle(
                            color: dark ? TColors.light : TColors.primary,
                          ),
                          prefixIconColor: TColors.primary,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const SaveAsBeneficiarySwitch(),
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
