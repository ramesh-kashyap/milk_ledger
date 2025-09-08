import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterDthRechargeDetailScreen extends StatelessWidget {
  EnterDthRechargeDetailScreen({Key? key}) : super(key: key);
  final TextEditingController tvController = TextEditingController();
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
            SizedBox(height: 20),
            CommonTextWidget.InterBold(
              text: "Enter Connection Details",
              fontSize: 22,
              color: black171,
            ),
            SizedBox(height: 25),
            CommonTextWidget.InterMedium(
              text: "DTH Operator",
              fontSize: 14,
              color: black171,
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              cursorColor: Colors.green,
              controller: tvController,
              style: TextStyle(
                color: black171,
                fontSize: 14,
                fontFamily: FontFamily.InterSemiBold,
              ),
              decoration: InputDecoration(
                hintText: "Airtel Digital TV",
                hintStyle: TextStyle(
                  color: black171,
                  fontSize: 16,
                  fontFamily: FontFamily.InterMedium,
                ),
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Image.asset(Images.airtelImage,
                          height: 25, width: 25),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: VerticalDivider(
                        color: greyA6A,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                        width: 10,
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CommonTextWidget.InterMedium(
                      text: "Change",
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
                ),
                filled: true,
                fillColor: whiteF9F,
                contentPadding: EdgeInsets.only(left: 15),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(88),
                    borderSide: BorderSide(color: greyA6A, width: 0.5)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(88),
                    borderSide: BorderSide(color: greyA6A, width: 0.5)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(88),
                    borderSide: BorderSide(color: greyA6A, width: 0.5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(88),
                    borderSide: BorderSide(color: greyA6A, width: 0.5)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(88),
                    borderSide: BorderSide(color: greyA6A, width: 0.5)),
              ),
            ),
            SizedBox(height: 20),
            CommonTextWidget.InterMedium(
              text: "Customer ID",
              fontSize: 14,
              color: black171,
            ),
            SizedBox(height: 10),
            CommonTextFieldWidget.TextFormField3(
              controller: numberController,
              hintText: "1234567890",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text:
                    "Enter 10 digit Customer ID starting with 3. to locate the customer ID, press the MENU button on your remote. ",
                style: TextStyle(
                  fontFamily: FontFamily.InterRegular,
                  fontSize: 12,
                  color: grey757,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Know More",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: FontFamily.InterRegular,
                        color: Colors.green),
                  ),
                ],
              ),
            ),
            Spacer(),
            CommonButtonWidget.button(
              onTap: () {},
              buttonColor: Colors.green,
              text: "Proceed",
            ),
            SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}
