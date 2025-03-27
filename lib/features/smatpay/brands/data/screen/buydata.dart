import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/features/smatpay/brands/data_sme/screen/success_page.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'dart:convert';

import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/constants/text_strings.dart';

class BuyDataPage extends StatefulWidget {
  @override
  _BuyDataPageState createState() => _BuyDataPageState();
}

class _BuyDataPageState extends State<BuyDataPage> {
  // Controllers for the form fields
  TextEditingController phoneController = TextEditingController();

  // Selected network and data size
  String selectedNetwork = 'mtn';
  String selectedDataSize = '500MB';

  // Token (Replace with your actual token)
  final String token = '86097ee7d1599a5043e519ca2';

  // List of data sizes
  final List<String> dataSizes = ['500MB', '1GB', '2GB', '3GB', '5GB', '10GB'];

  // Prices associated with data plans
  final Map<String, String> dataPrices = {
    '500MB': '170',
    '1GB': '290',
    '2GB': '580',
    '3GB': '870',
    '5GB': '1450',
    '10GB': '2900',
  };

  // To hold the selected amount
  String selectedAmount = '170'; // Default amount based on '500MB'

  // Function to handle data purchase
  // void purchaseData() {
  //   String phone = phoneController.text;

  //   if (phone.isNotEmpty) {
  //     buyData(token, selectedNetwork, phone, selectedDataSize);

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Purchasing $selectedDataSize for $phone...')),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please enter a phone number')),
  //     );
  //   }
  // }
  Future<bool> purchaseData() async {
    String phone = phoneController.text;

    if (phone.isNotEmpty) {
      return await buyData(token, selectedNetwork, phone, selectedDataSize);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a phone number')),
      );
      return false;
    }
  }

  // Future<void> buyData(
  //     String token, String network, String phone, String size) async {
  //   String url = 'https://smedata.ng/wp-json/api/v1/data';

  //   Map<String, String> queryParams = {
  //     'token': token,
  //     'network': network,
  //     'phone': phone,
  //     'size': size
  //   };

  //   // Building the full URL with query parameters
  //   String queryString = Uri(queryParameters: queryParams).query;
  //   var requestUrl = '$url?$queryString';

  //   try {
  //     var response = await http.get(Uri.parse(requestUrl));

  //     if (response.statusCode == 200) {
  //       var jsonResponse = json.decode(response.body);
  //       if (jsonResponse['code'] == 'success') {
  //         print('Data purchase successful: ${jsonResponse['message']}');
  //       } else {
  //         print('Error: ${jsonResponse['message']}');
  //       }
  //     } else {
  //       print('Failed to connect to API');
  //     }
  //   } catch (error) {
  //     print('An error occurred: $error');
  //   }
  // }

  Future<bool> buyData(
      String token, String network, String phone, String size) async {
    String url = 'https://smedata.ng/wp-json/api/v1/data';

    Map<String, String> queryParams = {
      'token': token,
      'network': network,
      'phone': phone,
      'size': size,
    };

    // Building the full URL with query parameters
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = '$url?$queryString';

    try {
      var response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['code'] == 'success') {
          print('Data purchase successful: ${jsonResponse['message']}');
          return true; // Purchase was successful
        } else {
          print('Error: ${jsonResponse['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${jsonResponse['message']}')),
          );
          return false; // Purchase was not successful
        }
      } else {
        print('Failed to connect to API');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to connect to API')),
        );
        return false; // Purchase was not successful
      }
    } catch (error) {
      print('An error occurred: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
      return false; // Purchase was not successful
    }
  }

  // Function to update selected amount based on the selected data size
  void updateSelectedAmount(String dataSize) {
    setState(() {
      selectedAmount = dataPrices[dataSize]!;
    });
  }

  // Function to handle network selection
  void selectNetwork(String network) {
    setState(() {
      selectedNetwork = network;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Network selection
            Text('Select Network'),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => selectNetwork('mtn'),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedNetwork == 'mtn'
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: selectedNetwork == 'mtn'
                          ? Colors.blue.withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Image.asset(
                          TImages.mtn, // Path to your MTN image
                          width: 60,
                          height: 60,
                        ),
                        Text('MTN'),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => selectNetwork('glo'),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedNetwork == 'glo'
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: selectedNetwork == 'glo'
                          ? Colors.blue.withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Image.asset(
                          TImages.glo, // Path to your GLO image
                          width: 60,
                          height: 60,
                        ),
                        Text('GLO'),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => selectNetwork('airtel'),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedNetwork == 'airtel'
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: selectedNetwork == 'airtel'
                          ? Colors.blue.withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Image.asset(
                          TImages.airtel, // Path to your AIRTEL image
                          width: 60,
                          height: 60,
                        ),
                        Text('AIRTEL'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Data size selection dropdown
            Text('Select Data Size'),
            DropdownButton<String>(
              value: selectedDataSize,
              isExpanded: true,
              items: dataSizes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDataSize = newValue!;
                  updateSelectedAmount(
                      selectedDataSize); // Update amount based on selection
                });
              },
            ),
            SizedBox(height: 16),

            // Display the amount
            Text('Amount: NGN $selectedAmount'),

            SizedBox(height: 16),

            // Phone number input
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              // decoration: InputDecoration(
              //   labelText: 'Phone Number',
              //   hintText: 'Enter phone number',
              //   border: OutlineInputBorder(),
              // ),
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.call),
                labelText: TTexts.phoneNo,
                labelStyle: TextStyle(
                    //    color: dark ? TColors.light : TColors.black,
                    ),
                prefixIconColor: TColors.primary,
              ),
            ),
            SizedBox(height: 16),

            // Purchase button

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                //  onPressed: purchaseData,
                onPressed: () {
                  purchaseData().then((success) {
                    if (success) {
                      // Redirect to the success page using GetX
                      Get.to(() => TSuccessPage(
                          message:
                              'Data purchased successfully! Amount: NGN ₦$selectedAmount'));
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(TSizes.md),
                    backgroundColor: TColors.primary,
                    side: const BorderSide(
                      color: TColors.primary,
                    )),
                child: const Text('Purchase Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// ANOTHER WORKING CODE 16TH OCTOBER 2024
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class BuyDataPage extends StatefulWidget {
//   @override
//   _BuyDataPageState createState() => _BuyDataPageState();
// }

// class _BuyDataPageState extends State<BuyDataPage> {
//   // Controllers for the form fields
//   TextEditingController phoneController = TextEditingController();

//   // Dropdown selections
//   String selectedNetwork = 'mtn';
//   String selectedDataSize = '1GB';

//   // Token (Replace with your actual token)
//   final String token = '86097ee7d1599a5043e519ca2';

//   // List of network options
//   final List<String> networks = ['mtn', 'glo', 'airtel'];

//   // List of data sizes
//   final List<String> dataSizes = ['500MB', '1GB', '2GB', '5GB', '10GB'];

//   // Prices associated with data plans
//   final Map<String, String> dataPrices = {
//     '500MB': '100',
//     '1GB': '200',
//     '2GB': '400',
//     '5GB': '1000',
//     '10GB': '2000',
//   };

//   // To hold the selected amount
//   String selectedAmount = '200'; // Default amount based on '1GB'

//   // Function to handle data purchase
//   void purchaseData() {
//     String phone = phoneController.text;

//     if (phone.isNotEmpty) {
//       buyData(token, selectedNetwork, phone, selectedDataSize);

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Purchasing $selectedDataSize for $phone...')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter a phone number')),
//       );
//     }
//   }

//   Future<void> buyData(
//       String token, String network, String phone, String size) async {
//     String url = 'https://smedata.ng/wp-json/api/v1/data';

//     Map<String, String> queryParams = {
//       'token': token,
//       'network': network,
//       'phone': phone,
//       'size': size
//     };

//     // Building the full URL with query parameters
//     String queryString = Uri(queryParameters: queryParams).query;
//     var requestUrl = '$url?$queryString';

//     try {
//       var response = await http.get(Uri.parse(requestUrl));

//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         if (jsonResponse['code'] == 'success') {
//           print('Data purchase successful: ${jsonResponse['message']}');
//         } else {
//           print('Error: ${jsonResponse['message']}');
//         }
//       } else {
//         print('Failed to connect to API');
//       }
//     } catch (error) {
//       print('An error occurred: $error');
//     }
//   }

//   // Function to update selected amount based on the selected data size
//   void updateSelectedAmount(String dataSize) {
//     setState(() {
//       selectedAmount = dataPrices[dataSize]!;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Buy Data'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Phone number input
//             TextField(
//               controller: phoneController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 labelText: 'Phone Number',
//                 hintText: 'Enter phone number',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),

//             // Network selection dropdown
//             Text('Select Network'),
//             DropdownButton<String>(
//               value: selectedNetwork,
//               isExpanded: true,
//               items: networks.map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value.toUpperCase()),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedNetwork = newValue!;
//                 });
//               },
//             ),
//             SizedBox(height: 16),

//             // Data size selection dropdown
//             Text('Select Data Size'),
//             DropdownButton<String>(
//               value: selectedDataSize,
//               isExpanded: true,
//               items: dataSizes.map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedDataSize = newValue!;
//                   updateSelectedAmount(
//                       selectedDataSize); // Update amount based on selection
//                 });
//               },
//             ),
//             SizedBox(height: 16),

//             // Display the amount
//             Text('Amount: NGN $selectedAmount'),

//             SizedBox(height: 16),

//             // Purchase button
//             Center(
//               child: ElevatedButton(
//                 onPressed: purchaseData,
//                 child: Text('Purchase Data'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// Previously working code 
// import 'package:smatpay/common/widgets/appbar/appbar.dart';
// import 'package:smatpay/utils/constants/colors.dart';
// import 'package:smatpay/utils/constants/image_strings.dart';
// import 'package:smatpay/utils/constants/sizes.dart';
// import 'package:smatpay/utils/constants/text_strings.dart';
// import 'package:smatpay/utils/helpers/helper_functions.dart';
// import 'package:smatpay/utils/validators/validation.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// class TBuyDataScreen extends StatefulWidget {
//   const TBuyDataScreen({super.key});

//   @override
//   State<TBuyDataScreen> createState() => _TBuyDataScreenState();
// }

// class _TBuyDataScreenState extends State<TBuyDataScreen> {
//   String? selectedDataPlan;
//   String? selectedOperator;
//   String? selectedAmount;
//   List<String> amountsList = [];
//   TextEditingController amountController = TextEditingController();

//   final Map<String, List<String>> dataPlans = {
//     'MTN': [
//       'MTN - DATA 500MB',
//       'MTN - DATA 1GB',
//       'MTN - DATA 2GB',
//       'MTN - DATA 3GB',
//       'MTN - DATA 5GB',
//       'MTN - DATA 10GB',
//     ],
//     'Airtel': [
//       'Airtel - DATA 500MB',
//       'Airtel - DATA 1GB',
//       'Airtel - DATA 2GB',
//       'Airtel - DATA 3GB',
//       'Airtel - DATA 5GB',
//       'Airtel - DATA 10GB',
//     ],
//     'Glo': [
//       'Glo - DATA 500MB',
//       'Glo - DATA 1GB',
//       'Glo - DATA 2GB',
//       'Glo - DATA 3GB',
//       'Glo - DATA 5GB',
//       'Glo - DATA 10GB',
//     ],
//     '9mobile': [
//       '9mobile - DATA 500MB',
//       '9mobile - DATA 1GB',
//       '9mobile - DATA 2GB',
//       '9mobile - DATA 3GB',
//       '9mobile - DATA 5GB',
//       '9mobile - DATA 10GB',
//     ],
//   };

//   final Map<String, List<String>> amountLists = {
//     'MTN - DATA 500MB': ['N135'],
//     'MTN - DATA 1GB': ['N265'],
//     'MTN - DATA 2GB': ['N530'],
//     'MTN - DATA 3GB': ['N795'],
//     'MTN - DATA 5GB': ['N1325'],
//     'MTN - DATA 10GB': ['N2650'],
//     'Airtel - DATA 500MB': ['N150'],
//     'Airtel - DATA 1GB': ['N300'],
//     'Airtel - DATA 2GB': ['N600'],
//     'Airtel - DATA 3GB': ['N900'],
//     'Airtel - DATA 5GB': ['N1500'],
//     'Airtel - DATA 10GB': ['N3000'],
//     'Glo - DATA 500MB': ['N100'],
//     'Glo - DATA 1GB': ['N200'],
//     'Glo - DATA 2GB': ['N400'],
//     'Glo - DATA 3GB': ['N600'],
//     'Glo - DATA 5GB': ['N1000'],
//     'Glo - DATA 10GB': ['N2000'],
//     '9mobile - DATA 500MB': ['N120'],
//     '9mobile - DATA 1GB': ['N240'],
//     '9mobile - DATA 2GB': ['N480'],
//     '9mobile - DATA 3GB': ['N720'],
//     '9mobile - DATA 5GB': ['N1200'],
//     '9mobile - DATA 10GB': ['N2400'],
//   };

//   @override
//   void initState() {
//     super.initState();
//     amountController.text = selectedAmount ?? '';
//   }

//   @override
//   void dispose() {
//     amountController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);

//     List<String> filteredDataPlans =
//         selectedOperator != null ? dataPlans[selectedOperator]! : [];

//     return Scaffold(
//       backgroundColor: dark ? TColors.secondary : TColors.softGrey,
//       appBar: const TAppBar(
//         title: Text('Buy Data'),
//         showBackArrow: true,
//         actions: [Icon(Iconsax.message_question)],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 60,
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 420,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.transparent,
//                   border: Border.all(
//                     color: TColors.grey, // Specify the border color
//                     width: 1, // Specify the border width
//                   ),
//                 ),
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Select Mobile Operator',
//                         style: Theme.of(context).textTheme.bodySmall!.apply(
//                               color: dark ? TColors.white : TColors.black,
//                             ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedOperator =
//                                     'Airtel'; // Changes the selected operator to 'Airtel'
//                                 selectedDataPlan =
//                                     null; // Resets the selected data plan to null
//                                 selectedAmount =
//                                     null; // Resets the selected amount to null
//                                 amountsList = amountLists[
//                                     'Airtel - DATA 500MB']!; // Sets amountsList to the list of amounts for 'Airtel - DATA 500MB'
//                                 amountController.text = selectedAmount ??
//                                     ''; // Updates the amountController's text to the selected amount or empty string
//                               });
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: selectedOperator == 'Airtel'
//                                       ? TColors.primary
//                                       : Colors.transparent,
//                                   width: 2,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Image.asset(
//                                 TImages.airtel,
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedOperator = 'Glo';
//                                 selectedDataPlan = null;
//                                 selectedAmount = null;
//                                 amountsList = amountLists['Glo - DATA 500MB']!;
//                                 amountController.text = selectedAmount ?? '';
//                               });
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: selectedOperator == 'Glo'
//                                       ? Colors.blue
//                                       : Colors.transparent,
//                                   width: 2,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Image.asset(
//                                 TImages.glo,
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedOperator = 'MTN';
//                                 selectedDataPlan = null;
//                                 selectedAmount = null;
//                                 amountsList = amountLists['MTN - DATA 500MB']!;
//                                 amountController.text = selectedAmount ?? '';
//                               });
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: selectedOperator == 'MTN'
//                                       ? Colors.blue
//                                       : Colors.transparent,
//                                   width: 2,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Image.asset(
//                                 TImages.mtn,
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedOperator = '9mobile';
//                                 selectedDataPlan = null;
//                                 selectedAmount = null;
//                                 amountsList =
//                                     amountLists['9mobile - DATA 500MB']!;
//                                 amountController.text = selectedAmount ?? '';
//                               });
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: selectedOperator == '9mobile'
//                                       ? Colors.blue
//                                       : Colors.transparent,
//                                   width: 2,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Image.asset(
//                                 TImages.ninemobile,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: TSizes.spaceBtwSections,
//                       ),
//                       Text(
//                         'Select Plan',
//                         style: Theme.of(context).textTheme.bodySmall!.apply(
//                               color: dark ? TColors.white : TColors.black,
//                             ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       DropdownButtonFormField<String>(
//                         hint: const Text('Select Plan'),
//                         value: selectedDataPlan,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             selectedDataPlan = newValue;
//                             selectedAmount = amountLists[newValue!]![
//                                 0]; // Set first amount by default
//                             amountsList = amountLists[newValue]!;
//                             amountController.text = selectedAmount ?? '';
//                           });
//                         },
//                         items: filteredDataPlans.map((String dataPlan) {
//                           return DropdownMenuItem<String>(
//                             value: dataPlan,
//                             child: Text(
//                               dataPlan,
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                       const SizedBox(
//                         height: TSizes.spaceBtwInputFields,
//                       ),
//                       TextFormField(
//                         controller: amountController,
//                         enabled: false,
//                         style: TextStyle(
//                           // Style for selected amount text
//                           fontSize: 16, // Increase font size
//                           color: dark
//                               ? TColors.light
//                               : TColors.black, // Set text color
//                         ),
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Iconsax.money),
//                           labelText: 'Selected Amount',
//                           labelStyle: TextStyle(
//                             color: dark ? TColors.light : TColors.black,
//                           ),
//                           prefixIconColor: TColors.primary,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: TSizes.spaceBtwInputFields,
//                       ),
//                       TextFormField(
//                         validator: (value) =>
//                             TValidator.validatePhoneNumber(value),
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                           prefixIcon: const Icon(Iconsax.call),
//                           labelText: TTexts.phoneNo,
//                           labelStyle: TextStyle(
//                             color: dark ? TColors.light : TColors.black,
//                           ),
//                           prefixIconColor: TColors.primary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: TSizes.spaceBtwSections,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                     onPressed: () {},
//                     //  => controller.signup(),
//                     style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.all(TSizes.md),
//                         backgroundColor: TColors.primary,
//                         side: const BorderSide(
//                           color: TColors.primary,
//                         )),
//                     child: const Text('Proceed to payment')),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


 

