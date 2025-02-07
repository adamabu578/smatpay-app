import 'package:smatpay/features/smatpay/brands/airtime/model/airtime_model.dart';
import 'package:smatpay/features/smatpay/brands/airtime/repository/airtime_repository.dart';
//import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  final DataRepository repository;

  DataController({required this.repository});

  var dataResponse = Rxn<DataResponse>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void purchaseData(String network, String phone, String size) async {
    isLoading.value = true;
    try {
      dataResponse.value = await repository.purchaseData(
        network: network,
        phone: phone,
        size: size,
      );
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
