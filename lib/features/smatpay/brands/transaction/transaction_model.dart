class TransactionModel {
  final String recipient;
  final double unitPrice;
  final int quantity;
  final double discount;
  final double totalAmount;
  final String status;
  final String createdAt;
  final String service;
  final String statusDescription;

  TransactionModel({
    required this.recipient,
    required this.unitPrice,
    required this.quantity,
    required this.discount,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.service,
    required this.statusDescription,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      recipient: json['recipient'] ?? '',
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
      service: json['service'] ?? '',
      statusDescription: json['statusDescription'] ?? '',
    );
  }
}