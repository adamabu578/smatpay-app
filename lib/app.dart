import 'package:smatpay/bindings/general_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/theme/theme.dart';

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

      /// Show Loader or Circular Progress Indicator meanwhile Authentication Repository is deciding to show relevant screen.

      home:
          //const TOnBoardingScreen(),
          const Scaffold(
        backgroundColor: TColors.primary2,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
      //  const TOnBoardingScreen(),

      /// Display the Remote Config version check screen on startup
      // home: const TRemoteConfig(),
    );
  }
}
