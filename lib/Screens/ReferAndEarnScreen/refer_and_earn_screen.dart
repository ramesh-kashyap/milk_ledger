import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ReferAndEarnScreen extends StatelessWidget {
  ReferAndEarnScreen({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                color: Colors.green,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 25, right: 25, top: 62, bottom: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child:
                                Icon(Icons.arrow_back, size: 20, color: white),
                          ),
                        SvgPicture.asset(Images.referAndEarnImage),
                          InkWell(
                            child: Icon(Icons.arrow_back,
                                size: 20, color: Colors.green),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: CommonTextWidget.InterSemiBold(
                          text: "Refer & Earn ₹100",
                          fontSize: 28,
                          color: white,
                        ),
                      ),
                      SizedBox(height: 8),
                      CommonTextWidget.InterRegular(
                        text:
                            "Earn ₹100 every time a referred friend makes their "
                            "1st UPI money transfer on DigiWallet",
                        fontSize: 14,
                        color: white,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: whiteF9F,
                            border: Border.all(color: greyA6A),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              children: [
                                Image.asset(Images.whatsApp,
                                    height: 24, width: 24),
                                SizedBox(width: 6),
                                CommonTextWidget.InterBold(
                                  text: "Refer via Whatsapp",
                                  fontSize: 14,
                                  color: black171,
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
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget.InterSemiBold(
                      text: "Choose from friend List below!",
                      fontSize: 18,
                      color: black171,
                    ),
                    SizedBox(height: 20),
                    CommonTextFieldWidget.TextFormField5(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child:SvgPicture.asset(Images.search, color: Colors.green),
                      ),
                      keyboardType: TextInputType.text,
                      hintText: "Search Name or Mobile No.",
                      controller: searchController,
                    ),
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: Lists.referAndEarnList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image.asset(
                            Lists.referAndEarnList[index]["image"],
                          ),
                          title: CommonTextWidget.InterSemiBold(
                            text: Lists.referAndEarnList[index]["text"],
                            fontSize: 16,
                            color: black051,
                          ),
                          subtitle: CommonTextWidget.InterMedium(
                            text: "Get ₹100 Cashback",
                            fontSize: 14,
                            color: green039,
                          ),
                          trailing: index == 2 || index == 3
                              ? Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: black.withOpacity(0.05),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Center(
                                      child: CommonTextWidget.InterRegular(
                                        text: "Accepted",
                                        fontSize: 12,
                                        color: black051.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 40,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.green.withOpacity(0.1),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Center(
                                      child: CommonTextWidget.InterRegular(
                                        text: "Invite",
                                        fontSize: 12,
                                        color: black051,
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
            ],
          ),
        ),
      ),
    );
  }
}
