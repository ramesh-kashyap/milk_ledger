import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'translations.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiService.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((value) => runApp(const DigiWalletPaytmCloneApp()));
}

class DigiWalletPaytmCloneApp extends StatelessWidget {
  const DigiWalletPaytmCloneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),  // ✅ translations added here
      locale: const Locale('en', 'US'), // ✅ default language
      fallbackLocale: const Locale('en', 'US'),
      home: SplashScreen(),             // ✅ your splash screen
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Colors.green),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
