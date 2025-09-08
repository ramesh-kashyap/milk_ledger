import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ScannerScreen/barCodeScreen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ScannerScreen/code_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PaymentCodeScreen extends StatelessWidget {
  PaymentCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
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
            CommonTextWidget.InterSemiBold(
              text: "Show this screen to cashier",
              fontSize: 18,
              color: black171,
            ),
            CommonTextWidget.InterRegular(
              text: "Payment code for mobile number",
              fontSize: 16,
              color: black171,
            ),
            CommonTextWidget.InterBold(
              text: "1234567890",
              fontSize: 30,
              color: black171,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 115),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(5),
                dashPattern: [2, 2],
                color: yellowEAB,
                strokeWidth: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: Container(
                    width: Get.width,
                    color: yellowEAB.withOpacity(0.08),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                      child: CommonTextWidget.InterBold(
                        text: "518 144",
                        fontSize: 24,
                        color: black171,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            CommonTextWidget.InterRegular(
              text: "Generate a New OTP",
              fontSize: 14,
              color: Colors.green,
            ),
            InkWell(
              onTap: () {
                Get.to(() => CodeScreen());
              },
              child: Container(
                height: 230,
                width: 230,
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
            ),
            InkWell(
              onTap: () {
                Get.to(() => BarCodeScreen());
              },
              child:SvgPicture.asset(Images.horizontealBarcodeImage),
            ),
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
            CommonTextWidget.InterSemiBold(
              text: "Add Money+",
              fontSize: 16,
              color: Colors.green,
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
