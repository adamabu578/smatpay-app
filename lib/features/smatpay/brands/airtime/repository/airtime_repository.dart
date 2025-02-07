import 'package:smatpay/features/smatpay/brands/airtime/model/airtime_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataRepository {
  final String baseUrl;
  final String token;

  DataRepository({required this.baseUrl, required this.token});

  Future<DataResponse> purchaseData({
    required String network,
    required String phone,
    required String size,
  }) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/data?token=$token&network=$network&phone=$phone&size=$size'),
    );

    if (response.statusCode == 200) {
      return DataResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}


// import 'package:http/http.dart' as http;

// class AirtimeRepository {
//   final String baseUrl;

//   AirtimeRepository(this.baseUrl);

//   Future<void> buyAirtime(Map<String, dynamic> data) async {
//     final url = Uri.parse('$baseUrl/buyAirtime');
//     try {
//       final response = await http.post(url, body: data);
//       if (response.statusCode == 200) {
//         // Handle successful response
//       } else {
//         // Handle server error response
//         throw Exception('Failed to buy airtime: ${response.reasonPhrase}');
//       }
//     } on http.ClientException catch (e) {
//       // Handle client exceptions (e.g., failed to connect to the server)
//       throw Exception('ClientException: $e');
//     } catch (e) {
//       // Handle other exceptions
//       throw Exception('An unexpected error occurred: $e');
//     }
//   }
// }

// class AirtimeRepository {
//   final String baseUrl;

//   AirtimeRepository(this.baseUrl);

//   Future<void> buyAirtime(Airtime airtime) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/buyAirtime'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(airtime.toJson()),
//       );

//       if (response.statusCode == 200) {
//         // Handle success
//       } else {
//         // Handle error
//         throw Exception('Failed to buy airtime');
//       }
//     } on http.ClientException catch (e) {
//       // Handle client exceptions (e.g., failed to connect to the server)
//       throw Exception('ClientException: $e');
//     } catch (e) {
//       // Handle other exceptions
//       throw Exception('An unexpected error occurred: $e');
//     }
//   }
// }
