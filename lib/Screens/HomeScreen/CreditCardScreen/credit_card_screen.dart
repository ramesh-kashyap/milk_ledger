import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreditCardScreen extends StatelessWidget {
  CreditCardScreen({Key? key}) : super(key: key);
  final TextEditingController numberController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();

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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child:SvgPicture.asset(Images.information, color: Colors.green,),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextWidget.InterBold(
              text: "Pay Your Credit Card Bill",
              fontSize: 22,
              color: black171,
            ),
            CommonTextWidget.InterBold(
              text: "Late fee Protection, Only on DigiWallet",
              fontSize: 14,
              color: black1E1,
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: CommonTextWidget.InterMedium(
                text: "Enter Credit Card Number",
                fontSize: 14,
                color: black171,
              ),
            ),
            SizedBox(height: 10),
            CommonTextFieldWidget.TextFormField3(
              controller: numberController,
              hintText: "XXXX - XXXX - XXXX - XXXX",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: CommonTextWidget.InterMedium(
                text: "Nickname (Optional)",
                fontSize: 14,
                color: black171,
              ),
            ),
            SizedBox(height: 10),
            CommonTextFieldWidget.TextFormField3(
              controller: nickNameController,
              hintText: "Enter Name",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8),
            CommonTextWidget.InterRegular(
              text: "Organise and pay the right card (i.e. my HDFC card)",
              fontSize: 12,
              color: grey757,
            ),
            SizedBox(height: 70),
            CommonButtonWidget.button(
              onTap: () {},
              buttonColor: Colors.green,
              text: "Proceed",
            ),
          ],
        ),
      ),
    );
  }
}
