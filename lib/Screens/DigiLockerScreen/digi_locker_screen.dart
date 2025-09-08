import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/DigiLockerScreen/digi_locker_search_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/DigiLockerScreen/digi_locker_viewall_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DigiLockerScreen extends StatelessWidget {
  DigiLockerScreen({Key? key}) : super(key: key);

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
        title: Image.asset(Images.digiLockerImage, height: 42, width: 135),
        actions: [
          SizedBox(width: 15),
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: InkWell(
              onTap: () {
                Get.to(() => DigiLockerSearchScreen());
              },
              child:SvgPicture.asset(Images.search),
            ),
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterSemiBold(
                      text: "Central Government",
                      fontSize: 16,
                      color: black171,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => DigiLockerViewAllScreen());
                      },
                      child: CommonTextWidget.InterBold(
                        text: "View All",
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                width: Get.width,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                        left: 20, right: 10, top: 15, bottom: 20),
                    itemCount: Lists.centralGovernmentList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        height: 200,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Image.asset(
                                Lists.centralGovernmentList[index]["image"],
                                height: 75,
                                width: 75,
                              ),
                              SizedBox(height: 12),
                              CommonTextWidget.InterSemiBold(
                                  color: black171,
                                  text: Lists.centralGovernmentList[index]
                                      ["text"],
                                  fontSize: 14,
                                  textAlign: TextAlign.center),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterSemiBold(
                      text: "State Government",
                      fontSize: 16,
                      color: black171,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => DigiLockerViewAllScreen());
                      },
                      child: CommonTextWidget.InterBold(
                        text: "View All",
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                width: Get.width,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                        left: 20, right: 10, top: 15, bottom: 20),
                    itemCount: Lists.statGovernmentList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        height: 200,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Image.asset(
                                Lists.statGovernmentList[index]["image"],
                                height: 75,
                                width: 75,
                              ),
                              SizedBox(height: 12),
                              CommonTextWidget.InterSemiBold(
                                  color: black171,
                                  text: Lists.statGovernmentList[index]["text"],
                                  fontSize: 14,
                                  textAlign: TextAlign.center),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterSemiBold(
                      text: "Education",
                      fontSize: 16,
                      color: black171,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => DigiLockerViewAllScreen());
                      },
                      child: CommonTextWidget.InterBold(
                        text: "View All",
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                width: Get.width,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                        left: 20, right: 10, top: 15, bottom: 20),
                    itemCount: Lists.educationGovernmentList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        height: 200,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Image.asset(
                                Lists.educationGovernmentList[index]["image"],
                                height: 75,
                                width: 75,
                              ),
                              SizedBox(height: 12),
                              CommonTextWidget.InterSemiBold(
                                  color: black171,
                                  text: Lists.educationGovernmentList[index]
                                      ["text"],
                                  fontSize: 14,
                                  textAlign: TextAlign.center),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterSemiBold(
                      text: "Banking and insurance",
                      fontSize: 16,
                      color: black171,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => DigiLockerViewAllScreen());
                      },
                      child: CommonTextWidget.InterBold(
                        text: "View All",
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                width: Get.width,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                        left: 20, right: 10, top: 15, bottom: 20),
                    itemCount: Lists.bankingAndInsuranceGovernmentList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        height: 200,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Image.asset(
                                Lists.bankingAndInsuranceGovernmentList[index]
                                    ["image"],
                                height: 75,
                                width: 75,
                              ),
                              SizedBox(height: 12),
                              CommonTextWidget.InterSemiBold(
                                  color: black171,
                                  text: Lists.bankingAndInsuranceGovernmentList[
                                      index]["text"],
                                  fontSize: 14,
                                  textAlign: TextAlign.center),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
