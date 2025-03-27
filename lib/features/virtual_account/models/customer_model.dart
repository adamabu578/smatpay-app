// lib/models/customer_model.dart

class TCustomerModel {
  final String email;
  final String firstName;
  final String lastName;
  final String phone;

  TCustomerModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
      };
}
