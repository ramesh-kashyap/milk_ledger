import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/WelcomePaytmScreen/welcome_paytm_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendSmsScreen extends StatelessWidget {
  SendSmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 400),
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
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Image.asset(Images.msgImage, height: 120, width: 120),
                  SizedBox(height: 6),
                  CommonTextWidget.InterSemiBold(
                    text: "Sending SMS",
                    fontSize: 20,
                    color: black171,
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Important: ",
                        style: TextStyle(
                          fontFamily: FontFamily.InterRegular,
                          fontSize: 14,
                          color: Colors.green,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                " Please do not press back or switch to another app while we are verifying your details.",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: FontFamily.InterRegular,
                                color: grey757),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                    child: CommonButtonWidget.button(
                      text: "Proceed Securely",
                      buttonColor: Colors.green,
                      onTap: () {
                        Get.to(() => WelcomePaytmScreen());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
