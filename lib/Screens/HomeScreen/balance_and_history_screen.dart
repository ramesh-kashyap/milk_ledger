import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BalanceAndHistoryScreen extends StatelessWidget {
  BalanceAndHistoryScreen({Key? key}) : super(key: key);

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
                  text: "Account Balance & History",
                  fontSize: 22,
                  color: black171,
                ),
                SizedBox(height: 25),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: Lists.accountBalanceHistoryList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: white,
                        border: Border.all(color: greyE5E, width: 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: whiteF9F,
                              child: index == 0
                                  ? Image.asset(
                                      Lists.accountBalanceHistoryList[index]
                                          ["image"],
                                      height: 9,
                                      width: 36)
                                  :SvgPicture.asset(
                                      Lists.accountBalanceHistoryList[index]
                                          ["image"]),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTextWidget.InterSemiBold(
                                    text: Lists.accountBalanceHistoryList[index]
                                        ["text1"],
                                    fontSize: 16,
                                    color: black171,
                                  ),
                                  SizedBox(height: 4),
                                  CommonTextWidget.InterRegular(
                                    text: Lists.accountBalanceHistoryList[index]
                                        ["text2"],
                                    fontSize: 12,
                                    color: grey757,
                                  ),
                                  SizedBox(height: 4),
                                  CommonTextWidget.InterBold(
                                    text: Lists.accountBalanceHistoryList[index]
                                        ["text3"],
                                    fontSize: 12,
                                    color: index == 0 ? black171 : Colors.green,
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
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterBold(
                      text: "Transaction history",
                      fontSize: 20,
                      color: grey757,
                    ),
                  SvgPicture.asset(Images.search),
                  ],
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Lists.accountBalanceTransactionHistoryList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                                Lists.accountBalanceTransactionHistoryList[
                                    index]["image"],
                                height: 45,
                                width: 45),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonTextWidget.InterSemiBold(
                                  text: Lists
                                          .accountBalanceTransactionHistoryList[
                                      index]["text1"],
                                  fontSize: 15,
                                  color: black171,
                                ),
                                SizedBox(height: 4),
                                CommonTextWidget.InterMedium(
                                  text: "Yesterday, 03:36 PM",
                                  fontSize: 12,
                                  color: grey757,
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    CommonTextWidget.InterMedium(
                                      text: "Sent From",
                                      fontSize: 12,
                                      color: grey757,
                                    ),
                                  SvgPicture.asset(Images.bobImge),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: CommonTextWidget.InterBold(
                                  text: Lists
                                          .accountBalanceTransactionHistoryList[
                                      index]["text2"],
                                  fontSize: 14,
                                  color: index == 1 ? green2CA : redE50,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Divider(color: greyF3F, thickness: 1),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                CommonTextWidget.InterBold(
                  text: "Yesterday, Dec 28",
                  fontSize: 14,
                  color: grey6B7,
                ),
                SizedBox(height: 15),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Lists.accountBalanceYesterdayHistoryList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                                Lists.accountBalanceYesterdayHistoryList[
                                index]["image"],
                                height: 45,
                                width: 45),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonTextWidget.InterSemiBold(
                                  text: Lists
                                      .accountBalanceYesterdayHistoryList[
                                  index]["text"],
                                  fontSize: 15,
                                  color: black171,
                                ),
                                SizedBox(height: 4),
                                CommonTextWidget.InterMedium(
                                  text: "Yesterday, 03:36 PM",
                                  fontSize: 12,
                                  color: grey757,
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    CommonTextWidget.InterMedium(
                                      text: "Sent From",
                                      fontSize: 12,
                                      color: grey757,
                                    ),
                                  SvgPicture.asset(Images.bobImge),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: CommonTextWidget.InterBold(
                                  text:"- ₹,1000",
                                  fontSize: 14,
                                  color:grey757,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Divider(color: greyF3F, thickness: 1),
                      ],
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
