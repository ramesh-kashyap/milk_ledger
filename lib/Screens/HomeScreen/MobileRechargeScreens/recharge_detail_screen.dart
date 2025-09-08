import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RechargeDetailScreen extends StatelessWidget {
  RechargeDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 550),
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
                padding:
                    EdgeInsets.only(top: 30, bottom: 50, left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget.InterBold(
                      text: "Plan Details",
                      fontSize: 20,
                      color: black171,
                    ),
                    SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget.InterBold(
                          text: "₹299",
                          fontSize: 20,
                          color: black171,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget.InterMedium(
                                text: "Validity: 28 Days",
                                fontSize: 14,
                                color: black171,
                              ),
                              SizedBox(height: 2),
                              CommonTextWidget.InterMedium(
                                text: "Date: 1.5/Day",
                                fontSize: 14,
                                color: black171,
                              ),
                              SizedBox(height: 4),
                              CommonTextWidget.InterRegular(
                                text: "Enjoy Unlimited calls on any network daily 1 GB & 100 SMS",
                                fontSize: 12,
                                color: grey757,
                              ),
                            ],
                          ),
                        ),
                      ],
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
