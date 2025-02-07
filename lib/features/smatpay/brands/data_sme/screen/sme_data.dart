import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/smatpay/brands/data_sme/screen/success_page.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'dart:convert';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/constants/sizes.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';
import 'package:smatpay/utils/popups/full_screen_loader.dart';

class TSmeDataScreen extends StatefulWidget {
  @override
  _TSmeDataScreenState createState() => _TSmeDataScreenState();
}

class _TSmeDataScreenState extends State<TSmeDataScreen> {
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
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your data purchase...', TImages.docerAnimation);

      var response = await http.get(Uri.parse(requestUrl));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['code'] == 'success') {
          print('Data purchase successful: ${jsonResponse['message']}');
          // Remove loader
          TFullScreenLoader.stopLoading();
          return true; // Purchase was successful
        } else {
          print('Error: ${jsonResponse['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${jsonResponse['message']}')),
          );
          // Remove loader
          TFullScreenLoader.stopLoading();
          return false; // Purchase was not successful
        }
      } else {
        print('Failed to connect to API');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to connect to API')),
        );
        // Remove loader
        TFullScreenLoader.stopLoading();
        return false; // Purchase was not successful
      }
    } catch (error) {
      print('An error occurred: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
      // Remove loader
      TFullScreenLoader.stopLoading();
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
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: TAppBar(
        title: Text('Buy Data'),
        showBackArrow: true,
        actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
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
                      SizedBox(height: 25),

                      // Data size selection dropdown
                      Text('Select Data Size'),
                      SizedBox(height: 20),
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
                      SizedBox(height: 20),

                      // Display the amount
                      Text('Amount'),
                      SizedBox(height: 10),
                      Text(
                        '₦ $selectedAmount',
                        style: Theme.of(context).textTheme.headlineSmall!.apply(
                              color: dark ? TColors.white : TColors.black,
                              fontFamily: 'NotoSans',
                            ),
                      ),

                      SizedBox(height: 20),

                      // Phone number input
                      Text('Phone Number'),
                      SizedBox(height: 10),
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
                          // labelText: TTexts.phoneNo,
                          // labelStyle: TextStyle(
                          //     //    color: dark ? TColors.light : TColors.black,
                          //     ),
                          prefixIconColor: TColors.primary,
                        ),
                      ),
                      SizedBox(height: 16),

                      // Purchase button
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
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
                                'Data purchased successfully! Amount: ₦$selectedAmount'));
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
      ),
    );
  }
}
