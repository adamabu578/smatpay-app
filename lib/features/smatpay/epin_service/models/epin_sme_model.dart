// To parse this JSON data, do
//
//     final smeData = smeDataFromJson(jsonString);

import 'dart:convert';

SmeData smeDataFromJson(String str) => SmeData.fromJson(json.decode(str));

String smeDataToJson(SmeData data) => json.encode(data.toJson());

class SmeData {
  int code;
  List<Description?> description;

  SmeData({
    required this.code,
    required this.description,
  });

  factory SmeData.fromJson(Map<String, dynamic> json) => SmeData(
        code: json["code"],
        description: List<Description?>.from(json["description"]
            .map((x) => x == null ? null : Description.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": List<dynamic>.from(description.map((x) => x?.toJson())),
      };
}

class Description {
  String network;
  String plan;
  String? epincode;
  String priceApi;

  Description({
    required this.network,
    required this.plan,
    required this.epincode,
    required this.priceApi,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        network: json["network"],
        plan: json["plan"],
        epincode: json["epincode"],
        priceApi: json["price_api"],
      );

  Map<String, dynamic> toJson() => {
        "network": network,
        "plan": plan,
        "epincode": epincode,
        "price_api": priceApi,
      };
}
