// controllers/data_controller.dart
import 'package:smatpay/features/smatpay/brands/data/model/data_model.dart';
import 'package:smatpay/features/smatpay/brands/data/repository/data_repository.dart';
import 'package:flutter/material.dart';

class DataController with ChangeNotifier {
  final DataRepository repository;

  DataController({required this.repository});

  List<DataPlan> _dataPlans = [];
  List<DataPlan> get dataPlans => _dataPlans;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> fetchDataPlans(String operator) async {
    _loading = true;
    notifyListeners();

    try {
      _dataPlans = await repository.fetchDataPlans(operator);
    } catch (e) {
      print('Failed to fetch data plans: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> buyDataPlan(String phone, DataPlan plan) async {
    try {
      await repository.buyDataPlan(phone, plan);
    } catch (e) {
      print('Failed to buy data plan: $e');
    }
  }
}
