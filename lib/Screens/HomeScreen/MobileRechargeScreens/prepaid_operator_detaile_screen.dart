import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/prepaid_operator_detaile_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MobileRechargeScreens/prepaid_operator_payment_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PrepaidOperatorDetailScreen extends StatelessWidget {
  PrepaidOperatorDetailScreen({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();
  final PrepaidOperatorDetailTabController prepaidOperatorDetailTabController =
      Get.put(PrepaidOperatorDetailTabController());

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
        title:SvgPicture.asset(Images.viPrepaidTitleImage),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
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
                Container(
                  height: 40,
                  width: Get.width,
                  color: white,
                  child: TabBar(
                    isScrollable: true,
                    tabs: prepaidOperatorDetailTabController.myTabs,
                    unselectedLabelColor: grey757,
                    labelStyle:
                        TextStyle(fontFamily: "InterSemiBold", fontSize: 13),
                    unselectedLabelStyle:
                        TextStyle(fontFamily: "InterMedium", fontSize: 13),
                    labelColor: black171,
                    controller: prepaidOperatorDetailTabController.controller,
                    indicatorColor: Colors.green,
                    indicatorWeight: 1.25,
                  ),
                ),
                SizedBox(height: 15),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: Lists.prepaidOperatorDetailList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => PrepaidOperatorPaymentScreen());
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonTextWidget.InterSemiBold(
                            text: Lists.prepaidOperatorDetailList[index],
                            fontSize: 20,
                            color: black171,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonTextWidget.InterMedium(
                                  text: "Validity: 28 Days",
                                  fontSize: 14,
                                  color: black171,
                                ),
                                SizedBox(height: 5),
                                RichText(
                                  text: TextSpan(
                                    text:
                                        "Just for you! EXTRA 0.5/Day with 1.5GB/ Day+unlimited Local/National Calls+100SMS Day. Validity:28Days. Binge Date: 12-6am every night+mon-fri’s unuse...",
                                    style: TextStyle(
                                      fontFamily: FontFamily.InterRegular,
                                      fontSize: 12,
                                      color: grey757,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "View More",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: FontFamily.InterRegular,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.arrow_forward_ios,
                                color: grey757, size: 18),
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
