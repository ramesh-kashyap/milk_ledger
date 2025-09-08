import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ApplyOfferScreen extends StatelessWidget {
  ApplyOfferScreen({Key? key}) : super(key: key);

  final TextEditingController enterCardNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 300),
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    CommonTextWidget.InterBold(
                      text: "Select a payment method to apply offer",
                      fontSize: 20,
                      color: black171,
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        CommonTextWidget.InterSemiBold(
                          text: "OFFER:",
                          fontSize: 12,
                          color: Colors.green,
                        ),
                        SizedBox(width: 10),
                        CommonTextWidget.InterSemiBold(
                          text: "DigiWallet Cashback worth ₹30",
                          fontSize: 12,
                          color: black171,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: white,
                        border: Border.all(color: greyE5E, width: 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonTextWidget.InterSemiBold(
                              text: "Use a New Debit Card",
                              fontSize: 12,
                              color: black171,
                            ),
                          SvgPicture.asset(Images.selectedIcon),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 22),
                    CommonTextFieldWidget.TextFormField3(
                      controller: enterCardNumberController,
                      hintText: "Enter Card Number",
                      keyboardType: TextInputType.number,
                    ),
                    Spacer(),
                    CommonButtonWidget.button(
                      text: "Apply Offer",
                      buttonColor: Colors.green,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
