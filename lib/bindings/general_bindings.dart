import 'package:get/get.dart';
import 'package:smatpay/utils/helpers/network_manager.dart';

import '../features/authentication/controllers/login/login_controller.dart';
import '../features/smatpay/brands/transaction/transaction_controller.dart';
import '../features/smatpay/controllers/wallet_controller.dart';
import '../features/virtual_account/controllers/create_virtual_account_controller.dart';
import '../navigation_menu.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TNetworkManager());
    Get.lazyPut(() => TLoginController());
    Get.lazyPut(() => NavigationController());
    Get.lazyPut(() => AccountController());
    Get.lazyPut(() => WalletController());
    Get.lazyPut(() => TransactionController());
    // Get.put(CourseRegistrationController());
  }
}
