import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MobileRechargeScreens/select_your_circle_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MobileRechargeScreens/select_your_postpaid_operator_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SelectYourPrepaidOperatorScreen extends StatelessWidget {
  SelectYourPrepaidOperatorScreen({Key? key}) : super(key: key);

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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child:SvgPicture.asset(Images.information),
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: CommonTextWidget.InterBold(
                  text: "Select your Prepaid Operator",
                  fontSize: 22,
                  color: black171,
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: Lists.selectYourPrepaidOperatorList.length,
                padding: EdgeInsets.symmetric(horizontal: 22),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: (){
                      Get.to(()=>SelectYourCircleScreen());
                    },
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: greyE5E, width: 1),
                        borderRadius: BorderRadius.circular(16),
                        color: white,
                      ),
                      child: ListTile(
                        leading: Image.asset(
                            Lists.selectYourPrepaidOperatorList[index]["image"],
                            height: 45,
                            width: 45),
                        title: CommonTextWidget.InterSemiBold(
                          text: Lists.selectYourPrepaidOperatorList[index]
                              ["text"],
                          fontSize: 16,
                          color: black171,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              InkWell(
                onTap: () {
                  Get.to(() => SelectYourPostpaidOperatorScreen2());
                },
                child: Container(
                  width: Get.width,
                  color: greyF3F,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Center(
                      child: CommonTextWidget.InterSemiBold(
                        text: "I am a Postpaid User",
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
