import 'dart:async';
import 'package:digitalwalletpaytmcloneapp/Screens/AuthScreens/login_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/home_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(Duration(seconds: 3)); // you can keep it 6 if you prefer

    final token = await ApiService.getToken();

    if (token != null && token.isNotEmpty) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LogInScreen());
    }
  }
}

