import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ChatScreens/chat_screen2.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PaymentScreens/pay_screen1.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ProfileScreen/profile_screen1.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen1 extends StatelessWidget {
  ChatScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 35,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(Icons.arrow_back, size: 20, color: white),
          ),
        ),
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => ProfileScreen1());
              },
              child: Image.asset(Images.jason2, height: 50, width: 50),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextWidget.InterSemiBold(
                  text: "Jason Adam",
                  fontSize: 16,
                  color: white,
                ),
                SizedBox(height: 3),
                CommonTextWidget.InterRegular(
                  text: "+91 12345 67890",
                  fontSize: 12,
                  color: white,
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(CupertinoIcons.ellipsis_vertical, color: white),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 12),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              /// Center Widget View
              CenterWidgetView(),

              /// BottomContainer Widget View
              BottomContainerWidgetView(),
            ],
          ),
        ),
      ),
    );
  }

  /// Center Widget View
  Widget CenterWidgetView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonTextWidget.InterMedium(
          text: "Verified Name",
          fontSize: 14,
          color: grey757,
        ),
        SizedBox(height: 5),
        CommonTextWidget.InterBold(
          text: "Jason Adam",
          fontSize: 22,
          color: black171,
        ),
        SizedBox(height: 5),
        CommonTextWidget.InterMedium(
          text: "On DigiWallet Since Aug 2021",
          fontSize: 14,
          color: grey757,
        ),
        SizedBox(height: 20),
        Container(
          height: 50,
          width: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: white,
            border: Border.all(color: greyE5E, width: 1),
          ),
          child: Center(
            child: CommonTextWidget.InterMedium(
              text: "Say Hello! 👋",
              fontSize: 22,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  /// BottomContainer Widget View
  Widget BottomContainerWidgetView() {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
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
        padding: EdgeInsets.only(top: 18, left: 25, right: 25, bottom: 30),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => PayScreen1());
              },
              child: Container(
                height: 56,
                width: 77,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.green,
                ),
                child: Center(
                  child:
                      Image.asset(Images.payRupieeImage, height: 17, width: 47),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.to(() => ChatScreen2());
                },
                child: Container(
                  height: 56,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: whiteF9F,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 18, bottom: 18, left: 16),
                    child: CommonTextWidget.InterRegular(
                      text: "Enter amount or message",
                      fontSize: 14,
                      color: grey9CA,
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
