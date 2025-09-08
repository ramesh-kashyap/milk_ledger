import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MobileRechargeScreens/prepaid_operator_detaile_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SelectYourCircleScreen extends StatelessWidget {
  SelectYourCircleScreen({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();

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
                  text: "Select your circle",
                  fontSize: 22,
                  color: black171,
                ),
                SizedBox(height: 15),
                CommonTextFieldWidget.TextFormField2(
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child:SvgPicture.asset(Images.search, color: Colors.green),
                  ),
                  keyboardType: TextInputType.text,
                  hintText: "Search",
                  controller: searchController,
                ),
                SizedBox(height: 15),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Lists.selectYourCircle2List.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => SelectYourCircleScreen());
                      },
                      child: InkWell(
                        onTap: () {
                          Get.to(() => PrepaidOperatorDetailScreen());
                        },
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            border: Border.all(color: greyE5E, width: 1),
                            borderRadius: BorderRadius.circular(16),
                            color: white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: CommonTextWidget.InterSemiBold(
                              text: Lists.selectYourCircle2List[index],
                              fontSize: 16,
                              color: black171,
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
    );
  }
}
