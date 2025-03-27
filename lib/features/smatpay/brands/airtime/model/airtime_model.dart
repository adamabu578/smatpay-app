class DataResponse {
  final String code;
  final String message;
  final DataDetails? data;

  DataResponse({
    required this.code,
    required this.message,
    this.data,
  });

  factory DataResponse.fromJson(Map<String, dynamic> json) {
    return DataResponse(
      code: json['code'],
      message: json['message'],
      data: json['data'] != null ? DataDetails.fromJson(json['data']) : null,
    );
  }
}

class DataDetails {
  final String network;
  final String dataPlan;
  final String phone;
  final String amount;
  final int orderId;

  DataDetails({
    required this.network,
    required this.dataPlan,
    required this.phone,
    required this.amount,
    required this.orderId,
  });

  factory DataDetails.fromJson(Map<String, dynamic> json) {
    return DataDetails(
      network: json['network'],
      dataPlan: json['data_plan'],
      phone: json['phone'],
      amount: json['amount'],
      orderId: json['order_id'],
    );
  }
}
