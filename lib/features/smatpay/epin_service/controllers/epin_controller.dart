import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smatpay/features/smatpay/epin_service/models/epin_sme_model.dart';

class SmeController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var selectedNetwork = ''.obs; // Network selection (e.g., "01" for MTN)
  var selectedDataSize = ''.obs; // Data plan code (e.g., "1000" for 1GB MTN)
  var selectedAmount = 0.obs; // Amount based on the selected data plan
  var phoneController = TextEditingController(); // For phone number input
  var dataPlans = <Description>[].obs; // Data plans for the selected network
  var errorMessage = ''.obs;
  var successMessage = ''.obs;

  // API key and base URL
  final String apiKey =
      "Z5x0QDtkaFKPGv15DSRDKee75LR24vP0IeQBCJTyg01kWQYIJpHSUf38UqfrvzxfTKMsGY3FuUUF7ubloiLyVIvKYIgJ9wI4egoslauh6h2FwomHjN7uU4Zi";
  final String apiUrl = "https:\/\/api.epins.com.ng\/v2\/autho";

  // Fetch available data plans (if needed)
  Future<void> fetchDataPlans(String networkCode) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // Simulated data fetching (update if your API provides data plans dynamically)
      var fetchedPlans = [
        Description(
            network: "01", plan: "1GB", epincode: "1000", priceApi: "260"),
        Description(
            network: "01", plan: "2GB", epincode: "2000", priceApi: "520"),
      ];
      dataPlans.value =
          fetchedPlans.where((plan) => plan.network == networkCode).toList();
    } catch (e) {
      errorMessage.value = "Failed to fetch data plans: $e";
    } finally {
      isLoading.value = false;
    }
  }

  // Update selected network
  void selectNetwork(String networkCode) {
    selectedNetwork.value = networkCode;
    selectedDataSize.value = '';
    selectedAmount.value = 0;
    fetchDataPlans(networkCode);
  }

  // Update selected data size and amount
  void updateSelectedDataSize(String dataSize) {
    selectedDataSize.value = dataSize;
    selectedAmount.value = int.parse(
        dataPlans.firstWhere((plan) => plan.epincode == dataSize).priceApi);
  }

  // Purchase SME Data
  Future<bool> purchaseData() async {
    if (selectedNetwork.value.isEmpty ||
        selectedDataSize.value.isEmpty ||
        phoneController.text.isEmpty) {
      errorMessage.value = "Please fill all the required fields.";
      return false;
    }

    isLoading.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    final uniqueRef = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // Unique transaction ref

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "apikey": apiKey,
          "service": selectedNetwork.value,
          "MobileNumber": phoneController.text,
          "DataPlan": selectedDataSize.value,
          "ref": uniqueRef,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['code'] == 101) {
          successMessage.value =
              responseData['description']['response_description'];
          return true;
        } else {
          errorMessage.value =
              responseData['description'] ?? "Transaction failed.";
          return false;
        }
      } else {
        errorMessage.value =
            "Failed to process the request: ${response.reasonPhrase}";
        return false;
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
