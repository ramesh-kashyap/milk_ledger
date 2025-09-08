import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CodeScreen extends StatelessWidget {
  CodeScreen({Key? key}) : super(key: key);

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(padding: EdgeInsets.only(top:40),
              child: CommonTextWidget.InterSemiBold(
                text: "Show this screen to cashier",
                fontSize: 18,
                color: black171,
              ),),
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: white.withOpacity(0.4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: grey6B7.withOpacity(0.06),
                    blurRadius: 25,
                    offset: Offset(2, 15),
                  ),
                ],
              ),
              child:SvgPicture.asset(Images.qrCodeImage),
            ),
            Column(
              children: [
                Container(
                  height: 35,
                  width: Get.width,
                  color: greyF3F,
                  child: Center(
                    child: CommonTextWidget.InterRegular(
                      text: "Available Wallet Balance ₹ 0",
                      fontSize: 18,
                      color: black171,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CommonTextWidget.InterSemiBold(
                  text: "Add Money+",
                  fontSize: 16,
                  color: Colors.green,
                ),
                SizedBox(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
