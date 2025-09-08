import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HelpScreen/help_screen3.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpScreen2ViewAllScreen extends StatelessWidget {
  HelpScreen2ViewAllScreen({Key? key}) : super(key: key);

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
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: Lists.helpViewAllList.length,
          padding: EdgeInsets.all(20),
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
                        Lists.helpViewAllList[index]["image"],
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextWidget.InterSemiBold(
                              text: Lists.helpViewAllList[index]["text1"],
                              fontSize: 14,
                              color: black171,
                            ),
                            CommonTextWidget.InterBold(
                              text: index == 1 || index == 3 || index == 8
                                  ? "Failure"
                                  : "Success",
                              fontSize: 14,
                              color: index == 1 || index == 3 || index == 8
                                  ? redE50
                                  : green2CA,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CommonTextWidget.InterBold(
                              text: Lists.helpViewAllList[index]["text2"],
                              fontSize: 16,
                              color: black171,
                            ),
                            CommonTextWidget.InterMedium(
                              text: Lists.helpViewAllList[index]["text3"],
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
    );
  }
}
