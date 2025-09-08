import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatScreen2 extends StatelessWidget {
  ChatScreen2({Key? key}) : super(key: key);

  final TextEditingController chatController = TextEditingController();

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
                // Get.to(() => ProfileScreen());
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
      children: [
        SizedBox(height: 14),
        Center(
          child: CommonTextWidget.InterRegular(
            color: grey757,
            fontSize: 14,
            text: "21 Apr 2022",
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 25, bottom: 20),
            child: Container(
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: whiteF3F,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget.InterBold(
                      color: black171,
                      fontSize: 26,
                      text: "₹ 1,200",
                    ),
                    SizedBox(height: 6),
                    Divider(thickness: 0.5, color: whiteDCE),
                    SizedBox(height: 6),
                    Row(
                      children: [
                      SvgPicture.asset(Images.circuleCheckIcon),
                        SizedBox(width: 5),
                        CommonTextWidget.InterRegular(
                          color: black171,
                          fontSize: 12,
                          text: "Received In BOB Bank",
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CommonTextWidget.InterRegular(
                        color: grey6B7,
                        fontSize: 10,
                        text: "9:40 PM",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: CommonTextWidget.InterRegular(
            color: grey757,
            fontSize: 14,
            text: "21 Apr 2022",
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(top: 20, right: 25),
            child: Container(
              height: 45,
              width: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                color: Colors.green,
              ),
              child: Center(
                child: CommonTextWidget.InterMedium(
                  color: white,
                  fontSize: 14,
                  text: "Hii",
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 25, bottom: 20, right: 25),
            child: Container(
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: whiteF3F,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget.InterBold(
                      color: black171,
                      fontSize: 26,
                      text: "₹ 100",
                    ),
                    SizedBox(height: 6),
                    Divider(thickness: 0.5, color: whiteDCE),
                    SizedBox(height: 6),
                    Row(
                      children: [
                      SvgPicture.asset(Images.circuleCheckIcon),
                        SizedBox(width: 5),
                        CommonTextWidget.InterRegular(
                          color: black171,
                          fontSize: 12,
                          text: "Paid to BOB Bank",
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CommonTextWidget.InterRegular(
                        color: grey6B7,
                        fontSize: 10,
                        text: "10:11 AM",
                      ),
                    ),
                  ],
                ),
              ),
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
            Expanded(
              child: CommonTextFieldWidget.TextFormField2(
                keyboardType: TextInputType.text,
                hintText: "Enter amount or message",
                controller: chatController,
                suffixIcon: Padding(
                  padding: EdgeInsets.all(12),
                  child:SvgPicture.asset(Images.rupieeImage),
                ),
              ),
            ),
            SizedBox(width: 12),
            InkWell(
              onTap: () {
                // Get.to(()=>ChatScreen2());
              },
              child:SvgPicture.asset(Images.rightArrowImage),
            ),
          ],
        ),
      ),
    );
  }
}
