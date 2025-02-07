import 'package:get/get.dart';
import 'package:smatpay/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TNetworkManager());
    // Get.put(CourseRegistrationController());
  }
}
