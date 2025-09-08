import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PaymentSettingScreen/SaveCardsScreen/add_card_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SaveCardsScreen extends StatelessWidget {
  SaveCardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 400),
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
                    text: "Saved Cards",
                    fontSize: 20,
                    color: black171,
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: greyE5E, width: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextWidget.InterSemiBold(
                              text: "Save your cards as per new RBI rules",
                              fontSize: 14,
                              color: black171,
                            ),
                            CommonTextWidget.InterRegular(
                              text: "And continue enjoying seamless payments.",
                              fontSize: 12,
                              color: grey6B7,
                            ),
                            CommonTextWidget.InterSemiBold(
                              text: "Know more",
                              fontSize: 12,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: InkWell(
                      onTap: () {
                        Get.bottomSheet(
                          AddCardScreen(),
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: whiteFCF,
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: ListTile(
                          horizontalTitleGap: 0,
                          leading:SvgPicture.asset(Images.addNewCardImage, color: Colors.green,),
                          title: CommonTextWidget.InterSemiBold(
                            text: "Add New Card",
                            fontSize: 14,
                            color: black171,
                          ),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: black171, size: 18),
                        ),
                      ),
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
