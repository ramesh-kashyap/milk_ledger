import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpScreen3 extends StatelessWidget {
  HelpScreen3({Key? key}) : super(key: key);

  final List chatList = [
    "Hi John! I’m your personal DigiWallet Assistant!",
    "we’re happy to inform you that your "
        "payment of ₹1,200 to Jason Adam "
        "Bank of Baroda account XX 1785 on "
        "30-09-2022 was successful. your UPI "
        "reference number is "
        "123456789012",
    "What can i help you with?",
    "Jason Adam did not receive the money",
    "Money was sent to the wrong person",
    "Issue with my cashback",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF9F,
      appBar: AppBar(
        backgroundColor: whiteF9F,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
        title: CommonTextWidget.InterSemiBold(
          text: "24x7 Help",
          fontSize: 18,
          color: black171,
        ),
      ),
      body: Align(
        alignment: Alignment.bottomLeft,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: chatList.length,
            padding: EdgeInsets.only(left: 25, right: 100, bottom: 50),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  border: Border.all(
                      color: index == 0 || index == 1 || index == 2
                          ? Colors.green.withOpacity(0.06)
                          : Colors.green,
                      width: index == 0 || index == 1 || index == 2 ? 0 : 1),
                  color: index == 0 || index == 1 || index == 2
                      ? Colors.green.withOpacity(0.06)
                      : whiteF9F,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: CommonTextWidget.InterRegular(
                    text: chatList[index],
                    fontSize: 14,
                    color: black091,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
