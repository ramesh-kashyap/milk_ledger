import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
      // for token check
import 'package:digitalwalletpaytmcloneapp/Screens/AuthScreens/login_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // Show splash for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Get token from storage (example)
    final token = await ApiService.getToken();

    if (token != null && token.isNotEmpty) {
      // ✅ User logged in → go to Home
      Get.offAll(() => HomeScreen());
    } else {
      // ❌ No token → go to Login
   
       Get.offAll(() => LogInScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF9F,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Image.asset(Images.splashImage),
        ),
      ),
    );
  }
}
