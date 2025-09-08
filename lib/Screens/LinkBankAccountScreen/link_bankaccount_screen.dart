import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/VerificationFailedScreen/verificationFailedScreen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LinkBankAccountScreen extends StatelessWidget {
  LinkBankAccountScreen({Key? key}) : super(key: key);

  final List<Map> linkBankAccountList = [
    {
      "image": Images.linkBankAccountImage1,
      "text": "Send money to any mobile No bank account or UOP ID",
    },
    {
      "image": Images.linkBankAccountImage2,
      "text": "Check balance of any bank account",
    },
    {
      "image": Images.linkBankAccountImage3,
      "text": "Scan any QR to pay at shops or at online websites",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF9F,
      appBar: AppBar(
        backgroundColor: whiteF9F,
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
            padding: EdgeInsets.only(top: 15, right: 25),
            child: CommonTextWidget.InterSemiBold(
              text: "SKIP",
              color: Colors.green,
              fontSize: 16,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: CommonTextWidget.InterBold(
              text: "Add your Bank a/c and get "
                  "₹10-100 on your 1st payment",
              fontSize: 20,
              color: black171,
            ),
          ),
          SizedBox(height: 40),
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 25),
            itemCount: linkBankAccountList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.only(bottom: 20),
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.green.withOpacity(0.1),
                child:SvgPicture.asset(
                  linkBankAccountList[index]["image"],
                ),
              ),
              title: CommonTextWidget.InterRegular(
                text: linkBankAccountList[index]["text"],
                fontSize: 15,
                color: grey757,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 45),
            child: CommonButtonWidget.button(
              text: "Link My Bank Account",
              buttonColor: Colors.green,
              onTap: () {
                Get.to(() => VerificationFailedScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}
