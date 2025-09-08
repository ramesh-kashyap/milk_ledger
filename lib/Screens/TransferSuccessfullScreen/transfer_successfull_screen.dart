import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ChatScreens/chat_screen1.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TransferSuccessfullScreen extends StatelessWidget {
  TransferSuccessfullScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFBF,
      appBar: AppBar(
        backgroundColor: whiteFBF,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: black,
              size: 24,
            ),
          ),
        ),
        title: Image.asset(Images.splashImage, height: 25, width: 99),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            CommonTextWidget.InterBold(
              text: "Transfer Successful!",
              fontSize: 24,
              color: black171,
            ),
            CommonTextWidget.InterRegular(
              text: "Payment transfer successful sent!",
              fontSize: 14,
              color: grey757,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SvgPicture.asset(Images.bobImge),
                SizedBox(width: 5),
                CommonTextWidget.InterRegular(
                  text: "Bank of Baroda A/c XX1234",
                  fontSize: 16,
                  color: black171,
                ),
              ],
            ),
            SizedBox(height: 15),
            CommonTextWidget.InterBold(
              text: "₹ 1,200",
              fontSize: 40,
              color: black171,
            ),
            SizedBox(height: 30),
          SvgPicture.asset(Images.transferSuccessFulImage),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: CommonButtonWidget.button(
                onTap: () {
                  Get.to(()=>ChatScreen1());
                },
                buttonColor: Colors.green,
                text: "Pay Again",
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 50),
              child: MaterialButton(
                onPressed: () {},
                height: 50,
                minWidth: Get.width,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                  side: BorderSide(color: greyA6A, width: 1),
                ),
                color: whiteFBF,
                child: CommonTextWidget.InterSemiBold(
                  fontSize: 16,
                  text: "Share",
                  color: black171,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
