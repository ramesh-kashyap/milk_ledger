import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HelpScreen/help_screen2_chooseservices_viewall_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HelpScreen/help_screen2_popularhelp_viewall_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HelpScreen/help_screen2_viewall_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HelpScreen/help_screen3.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HelpScreen2 extends StatelessWidget {
  HelpScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteFBF,
      appBar: AppBar(
        backgroundColor: whiteFBF,
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
          text: "24x7 Help",
          fontSize: 18,
          color: black171,
        ),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterBold(
                      text: "Recent Orders & Payments",
                      fontSize: 16,
                      color: black171,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => HelpScreen2ViewAllScreen());
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
              Padding(
                padding:
                    EdgeInsets.only(top: 4, left: 24, right: 24, bottom: 15),
                child: CommonTextWidget.InterBold(
                  text: "Select an order / payment you need help with",
                  fontSize: 11,
                  color: grey757,
                ),
              ),
              ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Lists.helpList.length,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => HelpScreen3());
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
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                Lists.helpList[index]["image"],
                                height: 40,
                                width: 40,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CommonTextWidget.InterSemiBold(
                                      text: Lists.helpList[index]["text1"],
                                      fontSize: 14,
                                      color: black171,
                                    ),
                                    CommonTextWidget.InterBold(
                                      text: index == 1 ? "Failure" : "Success",
                                      fontSize: 14,
                                      color: index == 1 ? redE50 : green2CA,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CommonTextWidget.InterBold(
                                      text: Lists.helpList[index]["text2"],
                                      fontSize: 16,
                                      color: black171,
                                    ),
                                    CommonTextWidget.InterMedium(
                                      text: Lists.helpList[index]["text3"],
                                      fontSize: 12,
                                      color: grey757,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterBold(
                      text: "Choose a service you need\n help with",
                      fontSize: 16,
                      color: black171,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => HelpScreen2ChooseServicesViewAllScreen());
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
              SizedBox(height: 12),
              SizedBox(
                height: 175,
                width: Get.width,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: Lists.helpList2.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                        height: 175,
                        width: 155,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: white,
                          border: Border.all(color: greyE5E, width: 1),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: greyE5E,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child:SvgPicture.asset(
                                        Lists.helpList2[index]["image"],
                                        color: Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 9),
                              CommonTextWidget.InterSemiBold(
                                color: black171,
                                text: Lists.helpList2[index]["text1"],
                                fontSize: 14,
                              ),
                              SizedBox(height: 3),
                              CommonTextWidget.InterRegular(
                                color: grey757,
                                text: Lists.helpList2[index]["text2"],
                                fontSize: 11,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterBold(
                      text: "Popular Help Topics",
                      fontSize: 16,
                      color: black171,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => HelpScreen2PopularHelpViewAllScreen());
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
              SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20),
                physics: NeverScrollableScrollPhysics(),
                itemCount: Lists.helpList3.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 10),
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
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                      child: Row(
                        children: [
                        SvgPicture.asset(
                            Lists.helpList3[index]["image"],
                            color: Colors.green,
                          ),
                          SizedBox(width: 22),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonTextWidget.InterSemiBold(
                                  text: Lists.helpList3[index]["text1"],
                                  fontSize: 14,
                                  color: black171,
                                ),
                                CommonTextWidget.InterRegular(
                                  text: Lists.helpList3[index]["text2"],
                                  fontSize: 12,
                                  color: grey757,
                                ),
                                CommonTextWidget.InterSemiBold(
                                  text: Lists.helpList3[index]["text3"],
                                  fontSize: 12,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                    title: CommonTextWidget.InterBold(
                      text: "Contact 24x7 Help",
                      fontSize: 16,
                      color: black171,
                    ),
                    subtitle: CommonTextWidget.InterRegular(
                      text: "Our executive will help solve your problem",
                      fontSize: 12,
                      color: grey757,
                    ),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: grey757, size: 18),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
