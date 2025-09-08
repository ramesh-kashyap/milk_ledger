import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MobileRechargeScreens/select_your_prepaid_operator_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MobileRechargeScreen extends StatelessWidget {
  MobileRechargeScreen({Key? key}) : super(key: key);
  final TextEditingController enterNumberController = TextEditingController();

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
            child:SvgPicture.asset(Images.information, color: Colors.green,),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CommonTextWidget.InterBold(
                  text: "Recharge or Pay Mobile Bill",
                  fontSize: 22,
                  color: black171,
                ),
                SizedBox(height: 15),
                CommonTextFieldWidget.TextFormField3(
                  controller: enterNumberController,
                  hintText: "Enter Name or Mobile Number",
                  keyboardType: TextInputType.number,
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(12),
                    child: InkWell(
                      onTap: () {
                        // Get.to(() => SearchContactScreen());
                      },
                      child:SvgPicture.asset(Images.book, color: Colors.green,),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                CommonTextWidget.InterBold(
                  text: "My Number",
                  fontSize: 20,
                  color: grey757,
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Get.to(() => SelectYourPrepaidOperatorScreen());
                  },
                  child: Row(
                    children: [
                      Image.asset(Images.jason, height: 45, width: 45),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonTextWidget.InterSemiBold(
                            text: "Jason Adam",
                            fontSize: 16,
                            color: black171,
                          ),
                          CommonTextWidget.InterRegular(
                            text: "+91 12345 67890",
                            fontSize: 12,
                            color: grey757,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                CommonTextWidget.InterBold(
                  text: "Select a Contact",
                  fontSize: 20,
                  color: grey757,
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Lists.mobileRechargeSelectContactList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => SelectYourPrepaidOperatorScreen());
                      },
                      child: Row(
                        children: [
                          Image.asset(
                              Lists.mobileRechargeSelectContactList[index]
                                  ["image"],
                              height: 45,
                              width: 45),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget.InterSemiBold(
                                text:
                                    Lists.mobileRechargeSelectContactList[index]
                                        ["text1"],
                                fontSize: 16,
                                color: black171,
                              ),
                              CommonTextWidget.InterRegular(
                                text:
                                    Lists.mobileRechargeSelectContactList[index]
                                        ["text2"],
                                fontSize: 12,
                                color: grey757,
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
          ),
        ),
      ),
    );
  }
}
