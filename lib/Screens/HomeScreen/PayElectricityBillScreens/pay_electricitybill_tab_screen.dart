import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/electricitybill_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/PayElectricityBillScreens/pay_apartmentsbill_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/PayElectricityBillScreens/pay_boardsbill_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PayElectricityBillTabScreen extends StatelessWidget {
  PayElectricityBillTabScreen({Key? key}) : super(key: key);
  final ElectricityBillTabController electricityBillTabController =
      Get.put(ElectricityBillTabController());

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
          text: "Pay Electricity Bill",
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
                tabs: electricityBillTabController.myTabs,
                unselectedLabelColor: black171,
                labelStyle:
                    TextStyle(fontSize: 16, fontFamily: "InterSemiBold"),
                unselectedLabelStyle:
                    TextStyle(fontSize: 16, fontFamily: "InterRegular"),
                labelColor: white,
                controller: electricityBillTabController.controller,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(32), color: Colors.green),
              ),
            ),
            SizedBox(height: 35),
            Expanded(
              child: TabBarView(
                controller: electricityBillTabController.controller,
                children: [
                  PayBoardsBillScreen(),
                  PayApartmentBillScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
