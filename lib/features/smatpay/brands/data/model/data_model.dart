// models/data_plan.dart
class DataPlan {
  final String operator;
  final String plan;
  final String amount;

  DataPlan({
    required this.operator,
    required this.plan,
    required this.amount,
  });

  factory DataPlan.fromJson(Map<String, dynamic> json) {
    return DataPlan(
      operator: json['operator'],
      plan: json['plan'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'operator': operator,
      'plan': plan,
      'amount': amount,
    };
  }
}
