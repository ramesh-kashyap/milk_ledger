import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/PayElectricityBillScreens/select_stat_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PayBoardsBillScreen extends StatelessWidget {
  PayBoardsBillScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Get.to(() => SelectStatScreen());
          },
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: greyE5E, width: 1),
              color: white,
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonTextWidget.InterSemiBold(
                    text: "Select State",
                    fontSize: 16,
                    color: black171,
                  ),
                  Icon(Icons.location_on, color: Colors.green),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 25),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: greyE5E, width: 1),
            color: white,
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SvgPicture.asset(Images.renewableEnergy),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget.InterSemiBold(
                        text: "Manage Automatic Payments",
                        fontSize: 14,
                        color: black171,
                      ),
                      SizedBox(height: 3),
                      CommonTextWidget.InterRegular(
                        text: "Setup new Edit existing Automatic Payments",
                        fontSize: 12,
                        color: grey6A7,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
