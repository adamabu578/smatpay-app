import 'package:smatpay/features/smatpay/home/screen/home.dart';
import 'package:smatpay/features/smatpay/profile/screen/profile.dart';
import 'package:smatpay/features/smatpay/services/screens/services.dart';
import 'package:smatpay/features/smatpay/wallet/screen/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TNavigationMenu extends StatelessWidget {
  const TNavigationMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
            height: 80,
            elevation: 1,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            backgroundColor: darkMode ? TColors.secondary : TColors.white,
            indicatorColor: darkMode
                ? TColors.white.withOpacity(0.1)
                : TColors.black.withOpacity(0.1),
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
              NavigationDestination(
                  icon: Icon(Iconsax.add_square), label: 'Services'),
              // NavigationDestination(
              //     icon: Icon(Iconsax.heart), label: 'Wishlist'),
              NavigationDestination(
                  icon: Icon(Iconsax.wallet_3), label: 'Wallet'),
              NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile')
            ]),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    TsmatpayHomeScreen(),
    const TServicesScreen(),
    const TWalletScreen(),
    const TProfileScreensmatpay(),

  ];
}

// Container(color: Colors.orange,),
// Container(color: Colors.blue,),