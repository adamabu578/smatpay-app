class VerifySmartCardResponse {
  final String status;
  final String message;
  final SmartCardData? data;

  VerifySmartCardResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory VerifySmartCardResponse.fromJson(Map<String, dynamic> json) {
    return VerifySmartCardResponse(
      status: json['status'] ?? 'error',
      message: json['msg'] ?? '',
      data: json['data'] != null ? SmartCardData.fromJson(json['data']) : null,
    );
  }

  bool get success => status == 'success';
}

class SmartCardData {
  final String customerName;
  final String status;
  final String dueDate;
  final String customerNumber;
  final String customerType;
  final double renewalAmount;
  final String currentBouquet;

  SmartCardData({
    required this.customerName,
    required this.status,
    required this.dueDate,
    required this.customerNumber,
    required this.customerType,
    required this.renewalAmount,
    required this.currentBouquet,
  });

  factory SmartCardData.fromJson(Map<String, dynamic> json) {
    return SmartCardData(
      customerName: json['customerName'] ?? '',
      status: json['status'] ?? '',
      dueDate: json['dueDate'] ?? '',
      customerNumber: json['customerNumber'] ?? '',
      customerType: json['customerType'] ?? '',
      renewalAmount: double.tryParse(json['renewalAmount'].toString()) ?? 0.0,
      currentBouquet: json['currentBouquet'] ?? '',
    );
  }
}