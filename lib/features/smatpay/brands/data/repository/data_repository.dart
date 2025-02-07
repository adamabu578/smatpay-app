// repositories/data_repository.dart
import 'dart:convert';
import 'package:smatpay/features/smatpay/brands/data/model/data_model.dart';
import 'package:http/http.dart' as http;

class DataRepository {
  final String baseUrl;

  DataRepository({required this.baseUrl});

  Future<List<DataPlan>> fetchDataPlans(String operator) async {
    final response =
        await http.get(Uri.parse('$baseUrl/data_plans?operator=$operator'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => DataPlan.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data plans');
    }
  }

  Future<void> buyDataPlan(String phone, DataPlan plan) async {
    final response = await http.post(
      Uri.parse('$baseUrl/buy_data'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'phone': phone,
        'operator': plan.operator,
        'plan': plan.plan,
        'amount': plan.amount,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to buy data plan');
    }
  }
}
