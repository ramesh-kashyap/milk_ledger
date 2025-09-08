import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/OtpScreen/enter_pin_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PaymentScreens/use_pay_option_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PayScreen2 extends StatelessWidget {
  PayScreen2({Key? key}) : super(key: key);

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
      body: Column(
        children: [
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: white,
                border: Border.all(color: greyE5E, width: 1),
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: whiteF9F,
                  child:SvgPicture.asset(Images.bobImge),
                ),
                title: CommonTextWidget.InterSemiBold(
                  text: "Bank of Baroda XX1234",
                  fontSize: 16,
                  color: black171,
                ),
                subtitle: CommonTextWidget.InterMedium(
                  text: "Check Balance",
                  fontSize: 12,
                  color: Colors.green,
                ),
                trailing: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      UsePayOptionScreen(),
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                    );
                  },
                  child:SvgPicture.asset(Images.arrowDownIcon),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          CommonTextWidget.InterRegular(
            text: "You are Paying",
            fontSize: 14,
            color: black171,
          ),
          SizedBox(height: 11),
          CommonTextWidget.InterBold(
            text: "₹ 1,200",
            fontSize: 40,
            color: black171,
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
              child: CommonTextWidget.InterMedium(
                text: "Food",
                fontSize: 14,
                color: black171,
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
                  padding:
                      EdgeInsets.only(top: 18, left: 25, right: 25, bottom: 30),
                  child: CommonButtonWidget.button(
                    text: "Pay ₹ 1,200 ",
                    buttonColor: Colors.green,
                    onTap: () {
                      Get.to(() => EnterPinScreen());
                    },
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
