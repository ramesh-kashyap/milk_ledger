import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/OtpScreen/otp_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

class PermissionScreen extends StatelessWidget {
  final String phone;
  const PermissionScreen({super.key, required this.phone});

  Future<void> _sendOtp() async {
    try {
      // optional: show loader
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      final response = await ApiService.post('/sendOtp', {"phone": phone});

      // print('Response: ${response.data}'); // Debugging line

      Get.back(); // close loader

      if (response.data['status'] == true) {
        // close bottom sheet
        if (Get.isBottomSheetOpen ?? false) Get.back();

        // go to OTP screen (adjust route/screen to your project)
        Get.to(() => OtpScreen(phone: phone));
      } else {
        Get.snackbar('Error', response.data['message'] ?? 'Failed to send OTP');
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 225),
      child: Column(
        children: [
          Container(
            height: 6,
            width: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: white,
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: white,
              ),
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 25, right: 25, bottom: 8),
                            child: CommonTextWidget.InterBold(
                              color: black171,
                              text: "Cancel",
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SvgPicture.asset(Images.permissionUserImage),
                      SizedBox(height: 28),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 52),
                        child: CommonTextWidget.InterSemiBold(
                          color: black171,
                          text: "To log in, we need an OTP",
                          fontSize: 20,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 26),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 52),
                        child: CommonTextWidget.InterRegular(
                          color: grey757,
                          text:
                              "This information is used to provide a secure login experience, ensuring that only you can access your Dashboard account",
                          fontSize: 14,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 52),
                        child: CommonTextWidget.InterRegular(
                          color: grey757,
                          text: "Location and SMS may also be used to give "
                              "you a richer experience through bill reminders, "
                              "deals, and recommen",
                          fontSize: 14,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 40, bottom: 25, left: 25, right: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ... permissions text/switches ...
                            const SizedBox(height: 16),
                            CommonButtonWidget.button(
                              text: "Proceed",
                              buttonColor: Colors.green,
                              onTap: _sendOtp,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
