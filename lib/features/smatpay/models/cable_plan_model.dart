class CablePlan {
  final String code;
  final String name;
  final double amount;
  final bool fixedPrice;

  CablePlan({
    required this.code,
    required this.name,
    required this.amount,
    required this.fixedPrice,
  });

  factory CablePlan.fromJson(Map<String, dynamic> json) {
    return CablePlan(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      fixedPrice: json['fixedPrice'] == 'Yes',
    );
  }
}

class PlansResponse {
  final String status;
  final String message;
  final List<CablePlan> plans;

  PlansResponse({
    required this.status,
    required this.message,
    required this.plans,
  });

  factory PlansResponse.fromJson(Map<String, dynamic> json) {
    return PlansResponse(
      status: json['status'] ?? 'error',
      message: json['msg'] ?? '',
      plans: (json['data'] as List?)?.map((e) => CablePlan.fromJson(e)).toList() ?? [],
    );
  }

  bool get success => status == 'success';
}