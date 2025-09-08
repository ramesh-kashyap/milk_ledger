import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/dth_recharge_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/DthRechargeScreen/cabletv_listview_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/DthRechargeScreen/dth_listview_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DthRechargeScreen extends StatelessWidget {
  DthRechargeScreen({Key? key}) : super(key: key);

  final DthRechargeTabController dthRechargeTabController =
      Get.put(DthRechargeTabController());

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
          text: "Recharge DTH or TV",
          fontSize: 18,
          color: black171,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child:SvgPicture.asset(Images.information, color: Colors.green,),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Container(
              height: 45,
              width: Get.width,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: greyF1F,
                borderRadius: BorderRadius.circular(35),
              ),
              child: TabBar(
                tabs: dthRechargeTabController.myTabs,
                unselectedLabelColor: black171,
                labelStyle:
                    TextStyle(fontSize: 16, fontFamily: "InterSemiBold"),
                unselectedLabelStyle:
                    TextStyle(fontSize: 16, fontFamily: "InterRegular"),
                labelColor: white,
                controller: dthRechargeTabController.controller,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.green),
              ),
            ),
            SizedBox(height: 25),
            CommonTextWidget.InterBold(
              text: "Recharge DTH or TV",
              fontSize: 20,
              color: black171,
            ),
            SizedBox(height: 18),
            Expanded(
              child: TabBarView(
                controller: dthRechargeTabController.controller,
                children: [
                  DthListviewScreen(),
                  CableTvListviewScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
