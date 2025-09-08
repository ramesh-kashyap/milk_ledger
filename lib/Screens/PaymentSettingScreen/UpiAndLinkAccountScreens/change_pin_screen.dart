import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChangePinScreen extends StatelessWidget {
  ChangePinScreen({Key? key}) : super(key: key);

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFBF,
      appBar: AppBar(
        backgroundColor: whiteFBF,
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
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CommonTextWidget.InterSemiBold(
                  text: "Create 4-digit UPI PIN using your debit card details",
                  fontSize: 18,
                  color: black171,
                ),
                SizedBox(height: 15),
                CommonTextWidget.InterRegular(
                  text: "Your PIN will be securely saved with Bank of "
                      "Baroda. DigiWallet will not store PIN. You will "
                      "need  to enter this PIN every time you make a "
                      "payment using your bank of Baroda account. "
                      "If your bank has merged with another bank "
                      "recently, you can use your existing debit card "
                      "with previous bank to set PIN.",
                  fontSize: 14,
                  color: black171,
                ),
                SizedBox(height: 30),
                CommonTextWidget.InterSemiBold(
                  text: "Bank of Baroda Debit Card",
                  fontSize: 14,
                  color: black171,
                ),
                SizedBox(height: 18),
                CommonTextWidget.InterRegular(
                  text: "Last 6 Digits  of Debit Card",
                  fontSize: 12,
                  color: grey757,
                ),
                CommonTextFieldWidget.TextFormField4(
                  keyboardType: TextInputType.number,
                  hintText: "XX XXXX",
                  controller: cardNumberController,
                ),
                SizedBox(height: 28),
                CommonTextWidget.InterRegular(
                  text: "Expiry / Validity Date",
                  fontSize: 12,
                  color: grey757,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonTextFieldWidget.TextFormField4(
                        keyboardType: TextInputType.text,
                        hintText: "MM",
                        controller: monthController,
                      ),
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: CommonTextFieldWidget.TextFormField4(
                        keyboardType: TextInputType.text,
                        hintText: "YY",
                        controller: yearController,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child:SvgPicture.asset(Images.bobImge),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                CommonTextWidget.InterRegular(
                  text:
                      "In case your card does not have an expiry date, enter 01/49",
                  fontSize: 12,
                  color: greyA6A,
                ),
                SizedBox(height: 30),
                CommonButtonWidget.button(
                  text: "Proceed",
                  buttonColor: Colors.green,
                  onTap: () {},
                ),
                SizedBox(height: 18),
                Center(
                  child: CommonTextWidget.InterSemiBold(
                    text: "I remember my old UPI PIN",
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
