import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;



class TAuthenticationRepository extends GetxController {
  static TAuthenticationRepository get instance => Get.find();

  /// Variable
  final deviceStorage = GetStorage();

  /// Called from main.dart on app launch

  @override
  void onReady() {
    // Remove the native splash screen
    FlutterNativeSplash.remove();
  }
  Future<bool> verifyToken(String token) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.smatpay.live/verify-token'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

}
