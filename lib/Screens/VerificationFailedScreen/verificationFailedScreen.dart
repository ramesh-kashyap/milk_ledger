// ignore_for_file: file_names

import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationFailedScreen extends StatelessWidget {
  VerificationFailedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 60),
            Image.asset(Images.faildSmsImage, height: 125, width: 125),
            SizedBox(height: 30),
            CommonTextWidget.InterBold(
              text: "Verification Failed",
              color: redFC5,
              fontSize: 20,
            ),
            SizedBox(height: 12),
            CommonTextWidget.InterRegular(
              text: "There was an error in sending SMS",
              color: grey757,
              fontSize: 15,
            ),
            SizedBox(height: 42),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 95),
              child: CommonButtonWidget.button(
                text: "Resend SMS",
                onTap: () {},
                buttonColor: Colors.green,
              ),
            ),
            Spacer(),
            Container(
              width: Get.width,
              color: greyF5F,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterMedium(
                      text:
                          "Do not have a bank account linked to mobile\n number 1234567890",
                      color: black171,
                      fontSize: 14,
                    ),
                    SizedBox(width: 20),
                    Icon(Icons.arrow_forward_ios, color: black171, size: 16),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
