import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PaymentSettingScreen/SaveCardsScreen/add_carddetail_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardScreen extends StatelessWidget {
  AddCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 450),
      child: Column(
        children: [
          Container(
            height: 6,
            width: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: white,
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: white,
              ),
              child: Column(
                children: [
                  SizedBox(height: 25),
                  CommonTextWidget.InterSemiBold(
                    text: "Add New Card",
                    fontSize: 20,
                    color: black171,
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: CommonTextWidget.InterRegular(
                      text: "We will debit ₹ 2 from your card to verify your "
                          "card details, ₹ 2 will be reversed in next 48 "
                          "hours.",
                      fontSize: 14,
                      color: grey757,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: CommonButtonWidget.button(
                      onTap: () {
                        Get.bottomSheet(
                          AddCardDetailScreen(),
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                        );
                      },
                      buttonColor: Colors.green,
                      text: "Proceed",
                    ),
                  ),
                  SizedBox(height: 18),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CommonTextWidget.InterSemiBold(
                      text: "Cancel",
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
