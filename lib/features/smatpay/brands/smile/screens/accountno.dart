import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TAccountNoScreen extends StatefulWidget {
  const TAccountNoScreen({super.key});

  @override
  State<TAccountNoScreen> createState() => _TAccountNoScreenState();
}

class _TAccountNoScreenState extends State<TAccountNoScreen> {
  String? selectedDataPlan;
  String? selectedAmount;
  String? selectedDuration;
  List<String> amountsList = [];
  TextEditingController amountController = TextEditingController();
  List<String> durationsList = [];
  TextEditingController durationController = TextEditingController();

  final List<String> dataPlans = [
    'SmileVoice ONLY 65',
    'SmileVoice ONLY 135',
    'SmileVoice ONLY 150',
    'SmileVoice ONLY 175',
    'SmileVoice ONLY 430',
    'SmileVoice ONLY 500',
    '1GB FlexiDaily',
    '2.5GB FlexiDaily',
    '1GB FlexiWeekly       ',
    '2GB FlexiDaily       ',
    'International SmileVoice ONLY 23',
    'International SmileVoice ONLY 60',
    'International SmileVoice ONLY 125',
    '1.5GB Bigga',
    '2GB Bigga',
    '3GB Bigga',
    '5GB Bigga',
    '6.5GB Bigga',
    '10GB Bigga',
    '15GB Bigga',
    'Freedom Best Effort',
    '35GB 360',
    '90GB Jumbo',
    '160GB Jumbo',
    'Freedom 3Mbps',
    'Freedom 6Mbps',
    '20GB Bigger',
    '25GB Bigger',
    '30GB Bigger',
    '40GB Bigger',
    '60GB Bigger',
    '75GB Bigger',
    'Unlimited Lite',
    'Unlimited Essentials',
    '2GB Midnight',
    '3GB Midnight',
    '2GB Weekend Only',
  ];

  final Map<String, List<String>> amountLists = {
    'SmileVoice ONLY 65': ['N600'],
    'SmileVoice ONLY 135': ['N1250'],
    'SmileVoice ONLY 150': ['N3850'],
    'SmileVoice ONLY 175': ['N4850'],
    'SmileVoice ONLY 430': ['N6050'],
    'SmileVoice ONLY 500': ['N330'],
    '1GB FlexiDaily': ['N550'],
    '2.5GB FlexiDaily': ['N550'],
    '1GB FlexiWeekly       ': ['N1800'],
    '2GB FlexiDaily       ': ['N2400'],
    'International SmileVoice ONLY 23': ['N1100'],
    'International SmileVoice ONLY 60': ['N1100'],
    'International SmileVoice ONLY 125': ['N1320'],
    '1.5GB Bigga': ['N1650'],
    '2GB Bigga': ['N2200'],
    '3GB Bigga': ['N2750'],
    '5GB Bigga': ['N3300'],
    '6.5GB Bigga': ['N9900'],
    '10GB Bigga': ['N44000'],
    '15GB Bigga': ['N20900'],
    'Freedom Best Effort': ['N22000'],
    '35GB 360': ['N37400'],
    '90GB Jumbo': ['N33000'],
    '160GB Jumbo': ['N5500'],
    'Freedom 3Mbps': ['N6600'],
    'Freedom 6Mbps': ['N8800'],
    '20GB Bigger': ['N11000'],
    '25GB Bigger': ['N14850'],
    '30GB Bigger': ['N16500'],
    '40GB Bigger': ['N1650'],
    '60GB Bigger': ['N135'],
    '75GB Bigger': ['N135'],
    'Unlimited Lite': ['N27500'],
    'Unlimited Essentials': ['N1250'],
    '2GB Midnight': ['N1350'],
    '3GB Midnight': ['N1460'],
    '2GB Weekend Only': ['N1750'],
  };

  final Map<String, List<String>> durationLists = {
    'SmileVoice ONLY 65': ['30 days'],
    'SmileVoice ONLY 135': ['30 days'],
    'SmileVoice ONLY 150': ['30 days'],
    'SmileVoice ONLY 175': ['30 days'],
    'SmileVoice ONLY 430': ['30 days'],
    'SmileVoice ONLY 500': ['30 days'],
    '1GB FlexiDaily': ['30 days'],
    '2.5GB FlexiDaily': ['30 days'],
    '1GB FlexiWeekly       ': ['30 days'],
    '2GB FlexiDaily       ': ['30 days'],
    'International SmileVoice ONLY 23': ['30 days'],
    'International SmileVoice ONLY 60': ['30 days'],
    'International SmileVoice ONLY 125': ['30 days'],
    '1.5GB Bigga': ['30 days'],
    '2GB Bigga': ['30 days'],
    '3GB Bigga': ['30 days'],
    '5GB Bigga': ['30 days'],
    '6.5GB Bigga': ['30 days'],
    '10GB Bigga': ['30 days'],
    '15GB Bigga': ['30 days'],
    'Freedom Best Effort': ['30 days'],
    '35GB 360': ['30 days'],
    '90GB Jumbo': ['30 days'],
    '160GB Jumbo': ['30 days'],
    'Freedom 3Mbps': ['30 days'],
    'Freedom 6Mbps': ['30 days'],
    '20GB Bigger': ['30 days'],
    '25GB Bigger': ['30 days'],
    '30GB Bigger': ['30 days'],
    '40GB Bigger': ['30 days'],
    '60GB Bigger': ['30 days'],
    '75GB Bigger': ['30 days'],
    'Unlimited Lite': ['30 days'],
    'Unlimited Essentials': ['30 days'],
    '2GB Midnight': ['30 days'],
    '3GB Midnight': ['30 days'],
    '2GB Weekend Only': ['30 days'],
  };

  // Map each item to its corresponding image path
  final Map<String, String> _dataPlansImages = {
    'SmileVoice ONLY 65': TImages.smilevoice,
    'SmileVoice ONLY 135': TImages.smilevoice,
    'SmileVoice ONLY 150': TImages.smilevoice,
    'SmileVoice ONLY 175': TImages.smilevoice,
    'SmileVoice ONLY 430': TImages.smilevoice,
    'SmileVoice ONLY 500': TImages.smilevoice,
    '1GB FlexiDaily': TImages.smilevoice,
    '2.5GB FlexiDaily': TImages.smilevoice,
    '1GB FlexiWeekly       ': TImages.smilevoice,
    '2GB FlexiDaily       ': TImages.smilevoice,
    'International SmileVoice ONLY 23': TImages.smilevoice,
    'International SmileVoice ONLY 60': TImages.smilevoice,
    'International SmileVoice ONLY 125': TImages.smilevoice,
    '1.5GB Bigga': TImages.smilevoice,
    '2GB Bigga': TImages.smilevoice,
    '3GB Bigga': TImages.smilevoice,
    '5GB Bigga': TImages.smilevoice,
    '6.5GB Bigga': TImages.smilevoice,
    '10GB Bigga': TImages.smilevoice,
    '15GB Bigga': TImages.smilevoice,
    'Freedom Best Effort': TImages.smilevoice,
    '35GB 360': TImages.smilevoice,
    '90GB Jumbo': TImages.smilevoice,
    '160GB Jumbo': TImages.smilevoice,
    'Freedom 3Mbps': TImages.smilevoice,
    'Freedom 6Mbps': TImages.smilevoice,
    '20GB Bigger': TImages.smilevoice,
    '25GB Bigger': TImages.smilevoice,
    '30GB Bigger': TImages.smilevoice,
    '40GB Bigger': TImages.smilevoice,
    '60GB Bigger': TImages.smilevoice,
    '75GB Bigger': TImages.smilevoice,
    'Unlimited Lite': TImages.smilevoice,
    'Unlimited Essentials': TImages.smilevoice,
    '2GB Midnight': TImages.smilevoice,
    '3GB Midnight': TImages.smilevoice,
    '2GB Weekend Only': TImages.smilevoice,
  };

  @override
  void initState() {
    super.initState();
    amountController.text = selectedAmount ?? '';
    durationController.text = selectedAmount ?? '';
  }

  @override
  void dispose() {
    amountController.dispose();
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
            border: Border.all(
              color: TColors.grey, // Specify the border color
              width: 1, // Specify the border width
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Select Plan',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(color: dark ? Colors.white : Colors.black),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  hint: const Text('Select Plan'),
                  value: selectedDataPlan,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDataPlan = newValue;
                      selectedAmount = amountLists[newValue!]![
                          0]; // Set first amount by default
                      amountsList = amountLists[newValue]!;
                      amountController.text = selectedAmount ?? '';
                      selectedDuration = durationLists[newValue]![
                          0]; // Set first duration by default
                      durationsList = durationLists[newValue]!;
                      durationController.text = selectedDuration ?? '';
                    });
                  },
                  items: dataPlans.map((smileBill) {
                    return DropdownMenuItem(
                      value: smileBill,
                      child: Row(
                        children: [
                          Image.asset(
                            _dataPlansImages[smileBill]!,
                            width: 40,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              smileBill,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(
                                      color:
                                          dark ? Colors.white : Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: amountController,
                  enabled: false,
                  style: TextStyle(
                    fontSize: 16,
                    color: dark ? TColors.white : TColors.black,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.money),
                    labelText: 'Selected Amount',
                    labelStyle:
                        TextStyle(color: dark ? Colors.white : Colors.black),
                    prefixIconColor: TColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: durationController,
                  enabled: false,
                  style: TextStyle(
                    fontSize: 16,
                    color: dark ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.money),
                    labelText: 'Selected Duration',
                    labelStyle:
                        TextStyle(color: dark ? Colors.white : Colors.black),
                    prefixIconColor: TColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter phone number' : null,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.call),
                    labelText: 'Phone Number',
                    labelStyle:
                        TextStyle(color: dark ? Colors.white : Colors.black),
                    prefixIconColor: TColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
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
              child: const Text('BUY With ACCT NO.')),
        ),
      ],
    );
  }
}
