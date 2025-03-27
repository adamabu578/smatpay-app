import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/features/smatpay/brands/data_sme/screen/success_page.dart';
import 'package:smatpay/features/smatpay/epin_service/controllers/epin_controller.dart';
import 'package:smatpay/utils/constants/image_strings.dart';

class TEPinDataScreen extends StatelessWidget {
  TEPinDataScreen({Key? key}) : super(key: key);

  final SmeController smeController = Get.put(SmeController());

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: dark ? Colors.black : Colors.grey[200],
      appBar: AppBar(
        title: const Text('Buy Data'),
        backgroundColor: dark ? Colors.grey[850] : Colors.white,
        foregroundColor: dark ? Colors.white : Colors.black,
        elevation: 0,
        actions: const [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: dark ? Colors.grey[900] : Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Network selection
                    const Text('Select Network'),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => smeController.selectNetwork('01'),
                          child: Obx(() => _buildNetworkOption(
                                isSelected:
                                    smeController.selectedNetwork.value == '01',
                                label: 'MTN',
                                assetPath:
                                    TImages.mtn, // Path to your MTN image
                                //'assets/images/mtn.png',
                              )),
                        ),
                        GestureDetector(
                          onTap: () => smeController.selectNetwork('02'),
                          child: Obx(() => _buildNetworkOption(
                                isSelected:
                                    smeController.selectedNetwork.value == '02',
                                label: 'GLO',
                                assetPath: TImages.glo,
                              )),
                        ),
                        GestureDetector(
                          onTap: () => smeController.selectNetwork('04'),
                          child: Obx(() => _buildNetworkOption(
                                isSelected:
                                    smeController.selectedNetwork.value == '04',
                                label: 'AIRTEL',
                                assetPath: TImages.airtel,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Data size selection dropdown
                    const Text('Select Data Size'),
                    const SizedBox(height: 20),
                    Obx(() {
                      return DropdownButton<String>(
                        value: smeController.selectedDataSize.value.isEmpty
                            ? null
                            : smeController.selectedDataSize.value,
                        isExpanded: true,
                        items: smeController.dataPlans.map((plan) {
                          return DropdownMenuItem<String>(
                            value: plan.epincode,
                            child: Text(plan.plan),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            smeController.updateSelectedDataSize(newValue);
                          }
                        },
                      );
                    }),
                    const SizedBox(height: 20),

                    // Display the amount
                    const Text('Amount'),
                    const SizedBox(height: 10),
                    Obx(() {
                      return Text(
                        '₦ ${smeController.selectedAmount.value}',
                        style: Theme.of(context).textTheme.headlineSmall!.apply(
                              color: dark ? Colors.white : Colors.black,
                              fontFamily: 'NotoSans',
                            ),
                      );
                    }),
                    const SizedBox(height: 20),

                    // Phone number input
                    const Text('Phone Number'),
                    const SizedBox(height: 10),
                    TextField(
                      controller: smeController.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.call),
                        prefixIconColor: Colors.blue,
                        hintText: 'Enter phone number',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Purchase button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final success = await smeController.purchaseData();
                    if (success) {
                      Get.to(() => TSuccessPage(
                          message: smeController.successMessage.value));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Purchase Data'),
                ),
              ),

              // Display loading, success, or error message
              const SizedBox(height: 20),
              Obx(() {
                if (smeController.isLoading.value) {
                  return const CircularProgressIndicator();
                } else if (smeController.errorMessage.value.isNotEmpty) {
                  return Text(
                    smeController.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  );
                } else if (smeController.successMessage.value.isNotEmpty) {
                  return Text(
                    smeController.successMessage.value,
                    style: const TextStyle(color: Colors.green),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkOption({
    required bool isSelected,
    required String label,
    required String assetPath,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Image.asset(
            assetPath,
            width: 60,
            height: 60,
          ),
          Text(label),
        ],
      ),
    );
  }
}



// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:iconsax/iconsax.dart';
// // import 'package:smatpay/common/widgets/appbar/appbar.dart';
// // import 'package:smatpay/features/smatpay/brands/data_sme/screen/success_page.dart';
// // import 'package:smatpay/features/smatpay/epin_service/controllers/epin_controller.dart';
// // import 'package:smatpay/utils/constants/colors.dart';
// // import 'package:smatpay/utils/constants/image_strings.dart';
// // import 'package:smatpay/utils/constants/sizes.dart';
// // import 'package:smatpay/utils/helpers/helper_functions.dart';

// // class TEpinDataScreen extends StatelessWidget {
// //   const TEpinDataScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final dark = THelperFunctions.isDarkMode(context);
// //     final SmeController controller = Get.put(SmeController());

// //     return Scaffold(
// //       backgroundColor: dark ? TColors.secondary : TColors.softGrey,
// //       appBar: TAppBar(
// //         title: Text('Buy Data'),
// //         showBackArrow: true,
// //         actions: [Icon(Iconsax.message_question)],
// //       ),
// //       body: Obx(() {
// //         if (controller.isLoading.value) {
// //           return const Center(child: CircularProgressIndicator());
// //         }

// //         if (controller.errorMessage.value.isNotEmpty) {
// //           return Center(child: Text(controller.errorMessage.value));
// //         }

// //         final smeData = controller.smeData.value;

// //         return SingleChildScrollView(
// //           child: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 16),
// //             child: Column(
// //               children: [
// //                 const SizedBox(height: 60),
// //                 Container(
// //                   width: double.infinity,
// //                   height: 480,
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(10),
// //                     color: dark ? TColors.primary2 : TColors.white,
// //                     border: Border.all(
// //                       color: TColors.grey,
// //                       width: 1,
// //                     ),
// //                   ),
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(16.0),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         // Network selection
// //                         const Text('Select Network'),
// //                         const SizedBox(height: 10),
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                           children: [
// //                             // MTN
// //                             GestureDetector(
// //                               onTap: () => controller.selectNetwork('mtn'),
// //                               child: Container(
// //                                 decoration: BoxDecoration(
// //                                   border: Border.all(
// //                                     color: controller.selectedNetwork.value == 'mtn'
// //                                         ? Colors.blue
// //                                         : Colors.grey,
// //                                   ),
// //                                   borderRadius: BorderRadius.circular(8),
// //                                   color: controller.selectedNetwork.value == 'mtn'
// //                                       ? Colors.blue.withOpacity(0.1)
// //                                       : Colors.transparent,
// //                                 ),
// //                                 padding: const EdgeInsets.all(8),
// //                                 child: Column(
// //                                   children: [
// //                                     Image.asset(
// //                                       TImages.mtn,
// //                                       width: 60,
// //                                       height: 60,
// //                                     ),
// //                                     const Text('MTN'),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                             // GLO
// //                             GestureDetector(
// //                               onTap: () => controller.selectNetwork('glo'),
// //                               child: Container(
// //                                 decoration: BoxDecoration(
// //                                   border: Border.all(
// //                                     color: controller.selectedNetwork.value == 'glo'
// //                                         ? Colors.blue
// //                                         : Colors.grey,
// //                                   ),
// //                                   borderRadius: BorderRadius.circular(8),
// //                                   color: controller.selectedNetwork.value == 'glo'
// //                                       ? Colors.blue.withOpacity(0.1)
// //                                       : Colors.transparent,
// //                                 ),
// //                                 padding: const EdgeInsets.all(8),
// //                                 child: Column(
// //                                   children: [
// //                                     Image.asset(
// //                                       TImages.glo,
// //                                       width: 60,
// //                                       height: 60,
// //                                     ),
// //                                     const Text('GLO'),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                             // Airtel
// //                             GestureDetector(
// //                               onTap: () => controller.selectNetwork('airtel'),
// //                               child: Container(
// //                                 decoration: BoxDecoration(
// //                                   border: Border.all(
// //                                     color: controller.selectedNetwork.value == 'airtel'
// //                                         ? Colors.blue
// //                                         : Colors.grey,
// //                                   ),
// //                                   borderRadius: BorderRadius.circular(8),
// //                                   color: controller.selectedNetwork.value == 'airtel'
// //                                       ? Colors.blue.withOpacity(0.1)
// //                                       : Colors.transparent,
// //                                 ),
// //                                 padding: const EdgeInsets.all(8),
// //                                 child: Column(
// //                                   children: [
// //                                     Image.asset(
// //                                       TImages.airtel,
// //                                       width: 60,
// //                                       height: 60,
// //                                     ),
// //                                     const Text('AIRTEL'),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                         const SizedBox(height: 25),

// //                         // Data size selection dropdown
// //                         const Text('Select Data Size'),
// //                         const SizedBox(height: 20),
// //                         DropdownButton<String>(
// //                           value: controller.selectedDataSize.value,
// //                           isExpanded: true,
// //                           items: controller.dataSizes
// //                               .map((size) => DropdownMenuItem(
// //                                     value: size,
// //                                     child: Text(size),
// //                                   ))
// //                               .toList(),
// //                           onChanged: (String? newValue) {
// //                             controller.selectDataSize(newValue!);
// //                           },
// //                         ),
// //                         const SizedBox(height: 20),

// //                         // Display the amount
// //                         const Text('Amount'),
// //                         const SizedBox(height: 10),
// //                         Text(
// //                           '₦ ${controller.selectedAmount.value}',
// //                           style: Theme.of(context).textTheme.headlineSmall!.apply(
// //                                 color: dark ? TColors.white : TColors.black,
// //                                 fontFamily: 'NotoSans',
// //                               ),
// //                         ),

// //                         const SizedBox(height: 20),

// //                         // Phone number input
// //                         const Text('Phone Number'),
// //                         const SizedBox(height: 10),
// //                         TextField(
// //                           controller: controller.phoneController,
// //                           keyboardType: TextInputType.phone,
// //                           decoration: InputDecoration(
// //                             prefixIcon: const Icon(Iconsax.call),
// //                             prefixIconColor: TColors.primary,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 16),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 30),
// //                 SizedBox(
// //                   width: double.infinity,
// //                   child: ElevatedButton(
// //                     onPressed: () async {
// //                       final success = await controller.purchaseData();
// //                       if (success) {
// //                         Get.to(() => TSuccessPage(
// //                               message: 'Data purchased successfully! Amount: ₦${controller.selectedAmount.value}',
// //                             ));
// //                       }
// //                     },
// //                     style: ElevatedButton.styleFrom(
// //                       padding: const EdgeInsets.all(TSizes.md),
// //                       backgroundColor: TColors.primary,
// //                       side: const BorderSide(
// //                         color: TColors.primary,
// //                       ),
// //                     ),
// //                     child: const Text('Purchase Data'),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       }),
// //     );
// //   }
// // }
