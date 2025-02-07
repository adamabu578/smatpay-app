import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class TAlphaDataScreen extends StatefulWidget {
  const TAlphaDataScreen({super.key});

  @override
  State<TAlphaDataScreen> createState() => _TAlphaDataScreenState();
}

class _TAlphaDataScreenState extends State<TAlphaDataScreen> {
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
    'Alpha N600': ['30 days'],
    'Alpha N1100': ['30 days'],
    'Alpha N1600': ['30 days'],
    'Alpha N2100': ['30 days'],
    'Alpha N2600': ['30 days'],
    'Alpha N3120': ['30 days'],
    'Alpha N3620': ['30 days'],
    'Alpha N4150': ['30 days'],
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
        'Plan: $selectedDataPlan\nAmount: $selectedAmount\nDuration: $selectedDuration\nPhone: $phoneNumber';

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
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: dark ? Colors.grey[900] : Colors.grey[300],
      appBar: AppBar(
        title: const Text('Buy Alpha TopUp'),
        actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text('ALPHA'),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        hint: const Text('Select Plan'),
                        value: selectedDataPlan,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDataPlan = newValue;
                            selectedAmount = amountLists[newValue!]![0];
                            amountsList = amountLists[newValue]!;
                            amountController.text = selectedAmount ?? '';
                            selectedDuration = durationLists[newValue]![0];
                            durationsList = durationLists[newValue]!;
                            durationController.text = selectedDuration ?? '';
                          });
                        },
                        items: dataPlans.map((smileBill) {
                          return DropdownMenuItem(
                            value: smileBill,
                            child: Text(smileBill),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: amountController,
                        enabled: false,
                        decoration: const InputDecoration(
                          labelText: 'Selected Amount',
                          prefixIcon: Icon(Iconsax.money),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: durationController,
                        enabled: false,
                        decoration: const InputDecoration(
                          labelText: 'Selected Duration',
                          prefixIcon: Icon(Iconsax.clock),
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
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('BUY'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
