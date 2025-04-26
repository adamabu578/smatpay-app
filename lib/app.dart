import 'package:smatpay/bindings/general_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smatpay/features/authentication/screens/login/login.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/theme/theme.dart';

import 'data/repositories/authentication/authentication_repository.dart';
import 'features/authentication/controllers/login/login_controller.dart';
import 'features/authentication/controllers/profile/profile_controller.dart';
import 'navigation_menu.dart';

/// ---- Use this class to setup themes, initial Bindings any animations and much more

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: FutureBuilder(
        future: _checkAuthStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: TColors.primary2,
              body: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          }
          return snapshot.data ?? const TLoginScreen();
        },
      ),
    );
  }

  Future<Widget?> _checkAuthStatus() async {
    try {
      final loginController = Get.put(TLoginController());
      final token = await loginController.getToken();

      if (token != null && token.isNotEmpty) {
        final authRepo = Get.find<TAuthenticationRepository>();
        final isValid = await authRepo.verifyToken(token);
        if (isValid) {
          await Get.find<ProfileController>().loadUserProfile();
          return const TNavigationMenu();
        }
      }
      return null;
    } catch (e) {
      debugPrint("Auth check error: $e");
      return null;
    }
  }
}