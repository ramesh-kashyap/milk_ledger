import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CashBackWonScreen extends StatelessWidget {
  CashBackWonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25, left: 22, right: 22, bottom: 3),
            child: CommonTextWidget.InterBold(
              text: "₹1000",
              fontSize: 34,
              color: white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 22, right: 22, bottom: 18),
            child: CommonTextWidget.InterMedium(
              text: "Cashback Won",
              fontSize: 20,
              color: white,
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
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 22),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: CommonTextWidget.InterRegular(
                          text: "Today",
                          fontSize: 16,
                          color: grey757,
                        ),
                      ),
                      ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: Lists.todayList.length,
                          padding: EdgeInsets.all(20),
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    backgroundColor: white,
                                    contentPadding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 300,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CommonTextWidget.InterSemiBold(
                                                text: "YOU WON",
                                                fontSize: 25,
                                                color: white,
                                              ),
                                              CommonTextWidget.InterBold(
                                                text: "₹3",
                                                fontSize: 60,
                                                color: white,
                                              ),
                                              CommonTextWidget.InterSemiBold(
                                                text: "CASHBACK",
                                                fontSize: 25,
                                                color: white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 100,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 28),
                                            child: Center(
                                              child:
                                                  CommonTextWidget.InterMedium(
                                                text:
                                                    "For Fuel payment at IOCL petrol pump on Apr "
                                                    "27, 2022 Cashback has been credited to your "
                                                    "Bank Account on Apr 27, 2022",
                                                fontSize: 12,
                                                color: black171,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: greyEFE,
                                    ),
                                    child: Center(
                                      child:SvgPicture.asset(
                                          Lists.todayList[index]["image"]),
                                    ),
                                  ),
                                  title: CommonTextWidget.InterMedium(
                                    text: Lists.todayList[index]["text1"],
                                    fontSize: 14,
                                    color: black171,
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CommonTextWidget.InterBold(
                                        text: Lists.todayList[index]["text2"],
                                        fontSize: 16,
                                        color: green00A,
                                      ),
                                      CommonTextWidget.InterMedium(
                                        text: Lists.todayList[index]["text3"],
                                        fontSize: 10,
                                        color: grey757,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: CommonTextWidget.InterRegular(
                          text: "March 2022",
                          fontSize: 16,
                          color: grey757,
                        ),
                      ),
                      ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: Lists.marchList.length,
                          padding: EdgeInsets.all(20),
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              onTap: () {
                                // Get.to(() => HelpScreen3());
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
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: greyEFE,
                                    ),
                                    child: Center(
                                      child:SvgPicture.asset(
                                          Lists.marchList[index]["image"]),
                                    ),
                                  ),
                                  title: CommonTextWidget.InterMedium(
                                    text: Lists.marchList[index]["text1"],
                                    fontSize: 14,
                                    color: black171,
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CommonTextWidget.InterBold(
                                        text: Lists.marchList[index]["text2"],
                                        fontSize: 16,
                                        color: green00A,
                                      ),
                                      CommonTextWidget.InterMedium(
                                        text: Lists.marchList[index]["text3"],
                                        fontSize: 10,
                                        color: grey757,
                                      ),
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
            ),
          ),
        ],
      ),
    );
  }
}
