import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/smatpay/brands/smile/screens/accountno.dart';
import 'package:smatpay/features/smatpay/brands/smile/screens/phoneno.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TSmileBuyScreen extends StatefulWidget {
  const TSmileBuyScreen({super.key});

  @override
  State<TSmileBuyScreen> createState() => _TSmileBuyScreenState();
}

class _TSmileBuyScreenState extends State<TSmileBuyScreen> {
  int _selectedIndex = 0;

  final List<String> _tabs = ['Phone Number', 'Account Number'];
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: const TAppBar(
        title: Text('Buy Smile TopUp'),
        showBackArrow: true,
        actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                TImages.smilevoice,
                width: 100,
                height: 100,
              ),
              const Text('SMILE VOICE'),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.grey, // Specify the border color
                      width: 1, // Specify the border width
                    ),
                  ),
                  child: Row(
                    children: _tabs.asMap().entries.map((entry) {
                      final index = entry.key;
                      final label = entry.value;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _selectedIndex == index
                                  ? TColors
                                      .primary // White background for selected tab
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                label,
                                style: TextStyle(
                                  color: _selectedIndex == index
                                      ? TColors
                                          .white // Black text for selected tab
                                      : TColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              _selectedIndex == 0
                  ? const TPhoneNoScreen()
                  : const TAccountNoScreen(), // Show corresponding widget based on the selected index
              // /// Phone No
            ],
          ),
        ),
      ),
    );
  }
}
