import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/smatpay/brands/airtime/widgets/savebeneficiary.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TElectricityScreen extends StatefulWidget {
  const TElectricityScreen({super.key});

  @override
  State<TElectricityScreen> createState() => _TElectricityScreenState();
}

class _TElectricityScreenState extends State<TElectricityScreen> {
  String? selectedElectricity;
  final List<String> _electricity = [
    'Ibadan Electricity',
    'Jos Electricity',
    'Kaduna Electricity',
    'Abuja Electricity',
    'Eko Electricity',
    'Ikeja Disco',
    'Port Harcourt',
    'Enugu Electricity',
    'Kano Electricity',
    'Benin Electricity',
    'YEDC',
  ];

  // Map each item to its corresponding image path
  final Map<String, String> _electricityImages = {
    'Ibadan Electricity': TImages.dstv,
    'Jos Electricity': TImages.dstv,
    'Kaduna Electricity': TImages.dstv,
    'Abuja Electricity': TImages.dstv,
    'Eko Electricity': TImages.dstv,
    'Ikeja Disco': TImages.dstv,
    'Port Harcourt': TImages.dstv,
    'Enugu Electricity': TImages.dstv,
    'Kano Electricity': TImages.dstv,
    'Benin Electricity': TImages.dstv,
    'YEDC': TImages.dstv,
  };

  @override
  void initState() {
    super.initState();
    amountController.text = selectedAmount ?? '';
  }

////////////////
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
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

////////

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    // List<String> filteredDataPlans =
    //     selectedOperator != null ? dataPlans[selectedOperator]! : [];

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Electricity Bill'),
        showBackArrow: true,
        actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Container(
                width: double.infinity,
                height: 550,
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
                        'Provider',
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: dark ? TColors.white : TColors.black,
                            ),
                      ),

                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      DropdownButton<String>(
                        hint: Text(
                          'Select Provider',
                          style: Theme.of(context).textTheme.bodySmall!.apply(
                                color: dark ? TColors.white : TColors.black,
                              ),
                        ),
                        dropdownColor: TColors.white,
                        isExpanded: true,
                        underline: Container(),
                        value: selectedElectricity,
                        onChanged: (value) {
                          setState(() {
                            selectedElectricity = value!;
                          });
                        },
                        items: _electricity
                            .map((electricBill) => DropdownMenuItem(
                                  value: electricBill,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 40,
                                          child: Image.asset(_electricityImages[
                                              electricBill]!),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          electricBill,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .apply(
                                                color: TColors.primary,
                                              ),
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                        selectedItemBuilder: (context) => _electricity
                            .map(
                              (electricBill) => Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Image.asset(
                                        _electricityImages[electricBill]!),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    electricBill,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .apply(
                                          color: dark
                                              ? TColors.white
                                              : TColors.black,
                                        ),
                                  )
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                      Text(
                        'Type',
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
                            'Prepaid',
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

                      /// Amount
                      Text(
                        'Meter Number',
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
                          labelText: 'Enter Meter number',
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
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
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
