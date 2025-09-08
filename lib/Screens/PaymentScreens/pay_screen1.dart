import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PaymentScreens/pay_screen2.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PayScreen1 extends StatelessWidget {
  PayScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteFBF,
      appBar: AppBar(
        backgroundColor: whiteFBF,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: black171,
              size: 25,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 12),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 1.5),
                color: white,
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(Images.jason),
              ),
            ),
            SizedBox(height: 10),
            CommonTextWidget.InterBold(
              text: "Jason Adam",
              fontSize: 22,
              color: black171,
            ),
            SizedBox(height: 8),
            CommonTextWidget.InterBold(
              text: "To: Bank A/c of Jason Adam",
              fontSize: 14,
              color: black171,
            ),
            SizedBox(height: 3),
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
            SizedBox(height: 30),
            CommonTextWidget.InterRegular(
              text: "You are Paying",
              fontSize: 14,
              color: black171,
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 135),
              child: TextFormField(
                cursorColor: grey757,
                style: TextStyle(
                  color: black171,
                  fontSize: 40,
                  fontFamily: FontFamily.InterBold,
                ),
                decoration: InputDecoration(
                  hintText: "₹ 0",
                  hintStyle: TextStyle(
                    color: grey6B7,
                    fontSize: 40,
                    fontFamily: FontFamily.InterBold,
                  ),
                  filled: true,
                  fillColor: whiteFBF,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: whiteFBF, width: 0),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: whiteFBF, width: 0),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: whiteFBF, width: 0),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 40,
              width: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: greyF3F,
              ),
              child: Center(
                child: CommonTextWidget.InterRegular(
                  text: "Add Message",
                  fontSize: 14,
                  color: grey757,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        color: black.withOpacity(0.15),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 18, left: 25, right: 25, bottom: 30),
                    child: CommonButtonWidget.button(
                      text: "Next",
                      buttonColor: Colors.green,
                      onTap: () {
                        Get.to(() => PayScreen2());
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
