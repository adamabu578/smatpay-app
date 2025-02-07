import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/smatpay/brands/Alpha/screens/please_note.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class TAlphaTopUpDataScreen extends StatefulWidget {
  const TAlphaTopUpDataScreen({super.key});

  @override
  State<TAlphaTopUpDataScreen> createState() => _TAlphaTopUpDataScreenState();
}

class _TAlphaTopUpDataScreenState extends State<TAlphaTopUpDataScreen> {
  String? selectedDataPlan;
  String? selectedAmount;
  String? selectedDuration;
  String phoneNumber = '';
  List<String> amountsList = [];
  TextEditingController amountController = TextEditingController();
  List<String> durationsList = [];
  TextEditingController durationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final List<String> dataPlans = [
    'Alpha N600',
    'Alpha N1100',
    'Alpha N1600',
    'Alpha N2100',
    'Alpha N2600',
    'Alpha N3120',
    'Alpha N3620',
    'Alpha N4150',
  ];

  final Map<String, List<String>> amountLists = {
    'Alpha N600': ['N600'],
    'Alpha N1100': ['N1100'],
    'Alpha N1600': ['N1600'],
    'Alpha N2100': ['N2100'],
    'Alpha N2600': ['N2600'],
    'Alpha N3120': ['N3120'],
    'Alpha N3620': ['N3620'],
    'Alpha N4150': ['N4150'],
  };

  final Map<String, List<String>> durationLists = {
    'SmileVoice ONLY 65': ['30 days'],
    'Alpha N600': ['30 days'],
    'Alpha N1100': ['30 days'],
    'Alpha N1600': ['30 days'],
    'Alpha N2100': ['30 days'],
    'Alpha N2600': ['30 days'],
    'Alpha N3120': ['30 days'],
    'Alpha N3620': ['30 days'],
    'Alpha N4150': ['30 days'],
  };

  // Map each item to its corresponding image path
  final Map<String, String> _dataPlansImages = {
    'Alpha N600': TImages.alphacaller,
    'Alpha N1100': TImages.alphacaller,
    'Alpha N1600': TImages.alphacaller,
    'Alpha N2100': TImages.alphacaller,
    'Alpha N2600': TImages.alphacaller,
    'Alpha N3120': TImages.alphacaller,
    'Alpha N3620': TImages.alphacaller,
    'Alpha N4150': TImages.alphacaller,
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

  // Function to share details to WhatsApp
  // Function to share details to WhatsApp

  Future<void> _shareToWhatsApp() async {
    final String phoneNumber = phoneNumberController.text;

    if (selectedDataPlan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a data plan')),
      );
      return;
    }

    if (selectedAmount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Amount is not selected')),
      );
      return;
    }

    if (selectedDuration == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Duration is not selected')),
      );
      return;
    }

    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter phone number')),
      );
      return;
    }

    final String message =
        'I want this Plan: $selectedDataPlan\nAmount: $selectedAmount\nDuration: $selectedDuration\nPhone: $phoneNumber';

    final Uri whatsappUrl = Uri.parse(
        'https://wa.me/2348164845671?text=${Uri.encodeComponent(message)}');

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch WhatsApp')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Buy Alpha TopUp'),
        showBackArrow: true,
        actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                TImages.alphacaller,
                width: 100,
                height: 100,
              ),
              const Text('ALPHA'),
              const SizedBox(
                height: 20,
              ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Select Plan',
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: dark ? TColors.white : TColors.black,
                            ),
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
                                          color: dark
                                              ? TColors.white
                                              : TColors.black,
                                        ),
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
                          labelStyle: TextStyle(
                              color: dark ? Colors.white : Colors.black),
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
                          labelStyle: TextStyle(
                              color: dark ? Colors.white : Colors.black),
                          prefixIconColor: TColors.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller:
                            phoneNumberController, // Add the controller here
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter phone number' : null,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.call),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                              color: dark ? Colors.white : Colors.black),
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
                    onPressed: _shareToWhatsApp,
                    //  => controller.signup(),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(TSizes.md),
                        backgroundColor: TColors.primary,
                        side: const BorderSide(
                          color: TColors.primary,
                        )),
                    child: const Text('BUY ')),
              ),
              SizedBox(
                height: 10,
              ),
              TAlphaPleaseNoteScreen()
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:smatpay/common/widgets/appbar/appbar.dart';
// import 'package:smatpay/features/smatpay/brands/Alpha/widgets/alphatopupdata.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// class TAlphaTopUpScreen extends StatelessWidget {
//   const TAlphaTopUpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       appBar: TAppBar(
//         title: Text('Buy Alpha TopUp'),
//         showBackArrow: true,
//         actions: [Icon(Iconsax.message_question)],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 50,
//               ),
//               TAlphaTopUpData(
//                 title: 'Alpha N600',
//                 amount: 'N600',
//                 duration: '30 days',
//               ),
//               TAlphaTopUpData(
//                 title: 'Alpha N1100',
//                 amount: 'N1100',
//                 duration: '30 days',
//               ),
//               TAlphaTopUpData(
//                 title: 'Alpha N1600',
//                 amount: 'N1600',
//                 duration: '30 days',
//               ),
//               TAlphaTopUpData(
//                 title: 'Alpha N2100',
//                 amount: 'N2100',
//                 duration: '30 days',
//               ),
//               TAlphaTopUpData(
//                 title: 'Alpha N2600',
//                 amount: 'N2600',
//                 duration: '30 days',
//               ),
//               TAlphaTopUpData(
//                 title: 'Alpha N3120',
//                 amount: 'N3120',
//                 duration: '30 days',
//               ),
//               TAlphaTopUpData(
//                 title: 'Alpha N3620',
//                 amount: 'N3620',
//                 duration: '30 days',
//               ),
//               TAlphaTopUpData(
//                 title: 'Alpha N4150',
//                 amount: 'N4150',
//                 duration: '30 days',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
