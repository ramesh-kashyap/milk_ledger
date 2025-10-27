import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/home_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PermissionScreen/complete_profile_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  final String phone;
  OtpScreen({super.key, required this.phone});

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  Future<void> _verifyOtp() async {
    print("its working");
    try {
      final res = await ApiService.post('/login', {
        "phone": phone,
        "otp": _pinPutController.text.trim(), // get OTP from Pinput
      });
    print('check..: ${res.data}');
      if (res.data['status'] == true) {
        final user = res.data['user'];
        // handle success -> save token, navigate to home
        await ApiService.saveToken(res.data['token']); // <<— ensure this runs
        if (user['name'] == null || user['address'] == null) {
          Get.bottomSheet(
            CompleteProfileScreen(userId: user['id']),
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
          );
        } else {
          // ✅ Profile complete → go to home
          Get.offAll(() => HomeScreen());
        }
      } else {
        Get.snackbar('Error', res.data['message'] ?? 'Invalid OTP');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(
        color: greyA6A,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF9F,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: whiteF9F,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 75),
            child: CommonTextWidget.InterBold(
              color: black171,
              text: "We have sent an OTP to $phone",
              fontSize: 20,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 9),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: CommonTextWidget.InterRegular(
              color: grey757,
              text: "Please ensure that the sim is present in this device",
              fontSize: 12,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40),
          SvgPicture.asset(Images.otpImage),
          SizedBox(height: 70),
          CommonTextWidget.InterRegular(
            color: grey757,
            text: "One Time Password (OTP)",
            fontSize: 12,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              color: whiteF9F,
              child: Pinput(
                length: 6,
                submittedPinTheme: PinTheme(
                  height: 40,
                  width: 40,
                  textStyle: TextStyle(
                    fontFamily: FontFamily.InterMedium,
                    fontSize: 24,
                    color: black171,
                  ),
                  decoration: BoxDecoration(
                    color: whiteF9F,
                    border: Border.all(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: whiteF9F,
                    border: Border.all(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                followingPinTheme: PinTheme(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: whiteF9F,
                    border: Border.all(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                defaultPinTheme: PinTheme(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: whiteF9F,
                    border: Border.all(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
              ),
            ),
          ),
          SizedBox(height: 25),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "Resend code in ",
              style: TextStyle(
                fontFamily: FontFamily.InterRegular,
                fontSize: 12,
                color: grey757,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "43 ",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: FontFamily.InterRegular,
                      color: Colors.green),
                ),
                TextSpan(
                  text: "second",
                  style: TextStyle(
                    fontFamily: FontFamily.InterRegular,
                    fontSize: 12,
                    color: grey757,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: CommonButtonWidget.button(
              text: "Continue",
              onTap:
                  _verifyOtp, // 👈 Call verify function instead of direct navigation
              buttonColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
