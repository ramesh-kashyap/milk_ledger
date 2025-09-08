import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/FilterScreen/filter_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/OrederAndBookingScreens/serach_order_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RecentOrderScreen extends StatelessWidget {
  RecentOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
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
          text: "Recent Orders",
          fontSize: 18,
          color: black171,
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.bottomSheet(
                FilterScreen(),
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
              );
            },
            child:SvgPicture.asset(Images.filterIcon),
          ),
          SizedBox(width: 15),
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: InkWell(
              onTap: () {
                Get.to(() => SearchOrderScreen());
              },
              child:SvgPicture.asset(Images.search),
            ),
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
          itemCount: Lists.recentOrderList.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: whiteFCF,
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(Lists.recentOrderList[index]["image"],
                            height: 40, width: 40),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextWidget.InterSemiBold(
                              text: Lists.recentOrderList[index]["text1"],
                              fontSize: 14,
                              color: black171,
                            ),
                            CommonTextWidget.InterSemiBold(
                              text: Lists.recentOrderList[index]["text2"],
                              fontSize: 12,
                              color: green2CA,
                            ),
                            CommonTextWidget.InterRegular(
                              text: "11 Apr 2022, 08:07 PM",
                              fontSize: 12,
                              color: grey757,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 34,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: whiteF9F,
                        border: Border.all(color: greyE5E, width: 1),
                      ),
                      child: Center(
                        child: CommonTextWidget.InterRegular(
                          text: "Repeat",
                          fontSize: 12,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
