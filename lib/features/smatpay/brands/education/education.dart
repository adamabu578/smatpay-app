import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:smatpay/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TEducationScreen extends StatefulWidget {
  const TEducationScreen({super.key});

  @override
  State<TEducationScreen> createState() => _TEducationScreenState();
}

class _TEducationScreenState extends State<TEducationScreen> {
  String? selectedEducation;
  String? selectedAmount;
  List<String> amountsList = [];
  TextEditingController amountController = TextEditingController();

  final List<String> _education = [
    'JAMB',
    'WAEC',
    'FUTO',
    'FUTA',
    'UNILAG',
    'UNIPORT',
    'UNN',
    'UNIZIK',
    'IMSU',
    'NEKEDE',
    'YABA TECH',
  ];

  // Map each item to its corresponding image path
  final Map<String, String> _educationImages = {
    'JAMB': TImages.dstv,
    'WAEC': TImages.dstv,
    'FUTO': TImages.dstv,
    'FUTA': TImages.dstv,
    'UNILAG': TImages.dstv,
    'UNIPORT': TImages.dstv,
    'UNN': TImages.dstv,
    'UNIZIK': TImages.dstv,
    'IMSU': TImages.dstv,
    'NEKEDE': TImages.dstv,
    'YABA TECH': TImages.dstv,
  };

  final Map<String, List<String>> amountLists = {
    'JAMB': ['N1,300'],
    'WAEC': ['N2,200'],
    'FUTO': ['N3,100'],
    'FUTA': ['N4,900'],
    'UNILAG': ['N5,800'],
    'UNIPORT': ['N6,700'],
    'UNN': ['N7,600'],
    'UNIZIK': ['N8,500'],
    'IMSU': ['N9,400'],
    'NEKEDE': ['N10,300'],
    'YABA TECH': ['N11,200'],
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

////////

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Education Bill'),
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
                height: 480,
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
                        value: selectedEducation,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedEducation = newValue!;
                            selectedAmount = amountLists[newValue]![
                                0]; // Set first amount by default
                            amountsList = amountLists[newValue]!;
                            amountController.text = selectedAmount ?? '';
                          });
                        },
                        items: _education
                            .map((educationBill) => DropdownMenuItem(
                                  value: educationBill,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 40,
                                          child: Image.asset(
                                              _educationImages[educationBill]!),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          educationBill,
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
                        selectedItemBuilder: (context) => _education
                            .map(
                              (educationBill) => Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Image.asset(
                                        _educationImages[educationBill]!),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    educationBill,
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
                        controller: amountController,
                        enabled: false,
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
                        height: TSizes.spaceBtwInputFields,
                      ),

                      /// Phone No
                      Text(
                        "Phone Number",
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
                          labelText: 'Enter Phone No',
                          labelStyle: TextStyle(
                            color: dark ? TColors.light : TColors.black,
                          ),
                          prefixIconColor: TColors.primary,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
                      ),

                      /// Email
                      Text(
                        "Email Address",
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: dark ? TColors.white : TColors.black,
                            ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) => TValidator.validateEmail(value),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.direct),
                          labelText: TTexts.email,
                          labelStyle: TextStyle(
                            color: dark ? TColors.light : TColors.black,
                          ),
                          prefixIconColor: TColors.primary,
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwInputFields,
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
                    child: const Text('Pay')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
