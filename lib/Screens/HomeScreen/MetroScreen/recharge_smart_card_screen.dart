import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RechargeSmartCardScreen extends StatelessWidget {
   RechargeSmartCardScreen({Key? key}) : super(key: key);
   final TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextWidget.InterBold(
              text: "Recharge Smart Card",
              fontSize: 22,
              color: black171,
            ),
            SizedBox(height: 25),
            CommonTextWidget.InterMedium(
              text: "Card Number",
              fontSize: 14,
              color: black171,
            ),
            SizedBox(height: 10),
            CommonTextFieldWidget.TextFormField3(
              controller: numberController,
              hintText: "12345678901",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8),
            CommonTextWidget.InterRegular(
              text: "Please enter your 11 digit Metro Smart Card number to recharge",
              fontSize: 12,
              color: grey757,
            ),
          Spacer(),
            CommonButtonWidget.button(
              onTap: () {},
              buttonColor: Colors.green,
              text: "Proceed",
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
