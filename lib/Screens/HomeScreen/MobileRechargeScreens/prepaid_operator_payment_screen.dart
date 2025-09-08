import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MobileRechargeScreens/apply_promocode_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MobileRechargeScreens/recharge_detail_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrepaidOperatorPaymentScreen extends StatelessWidget {
  PrepaidOperatorPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        children: [
          Container(
            color: Colors.green,
            child: Padding(
              padding:
                  EdgeInsets.only(top: 50, left: 22, right: 22, bottom: 18),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back, size: 20, color: white),
                  ),
                  SizedBox(width: 12),
                  Image.asset(Images.viPrepaidPaymentImage,
                      height: 50, width: 50),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget.InterSemiBold(
                        text: "Jason Adam",
                        fontSize: 16,
                        color: white,
                      ),
                      CommonTextWidget.InterRegular(
                        text: "+91 12345 67890",
                        fontSize: 12,
                        color: white,
                      ),
                      CommonTextWidget.InterRegular(
                        text: "Prepaid - Gujarat",
                        fontSize: 10,
                        color: white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(28),
                  topLeft: Radius.circular(28),
                ),
                color: white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 24, right: 24, left: 24, bottom: 15),
                    child: Container(
                      height: 65,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: greyE5E, width: 1),
                        color: white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CommonTextWidget.InterBold(
                          text: "₹ 299",
                          fontSize: 22,
                          color: black171,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 24, left: 24),
                    child: Container(
                      height: 50,
                      width: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: greyE5E, width: 1),
                        color: white,
                      ),
                      child: Center(
                        child: CommonTextWidget.InterMedium(
                          text: "Change Plan",
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  RechargeDetailScreen(),
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                );
                              },
                              child: Text(
                                "Recharge Details",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontFamily: FontFamily.InterMedium,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
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
                              padding: EdgeInsets.only(
                                  top: 18, left: 25, right: 25, bottom: 30),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => ApplyPromoCodeScreen());
                                      },
                                      child: Container(
                                        height: 55,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: whiteF9F,
                                        ),
                                        child: Center(
                                          child: CommonTextWidget.InterMedium(
                                            text: "Apply Promocode",
                                            fontSize: 14,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Container(
                                      height: 55,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.green,
                                      ),
                                      child: Center(
                                        child: CommonTextWidget.InterSemiBold(
                                          text: "Pay ₹299",
                                          fontSize: 20,
                                          color: white,
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
