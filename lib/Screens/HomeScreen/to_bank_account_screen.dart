import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ChatScreens/chat_screen1.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ToBankAccountScreen extends StatelessWidget {
  ToBankAccountScreen({Key? key}) : super(key: key);

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
          SvgPicture.asset(
            Images.information,
            color: Colors.green,
          ),
          SizedBox(width: 15),
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: SvgPicture.asset(
              Images.setting,
              color: Colors.green,
            ),
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
                  text: "Money transfer to Bank a/c",
                  fontSize: 22,
                  color: black171,
                ),
                SizedBox(height: 25),
                ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio:
                          MediaQuery.of(context).size.aspectRatio * 2 / 0.8,
                    ),
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: Lists.toBankAccountList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: Lists.toBankAccountList[index]["onTap"],
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: white,
                            border: Border.all(color: greyE5E, width: 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  Lists.toBankAccountList[index]["image"],
                                  color: Colors.green,
                                ),
                                SizedBox(height: 9),
                                CommonTextWidget.InterSemiBold(
                                  color: black171,
                                  text: Lists.toBankAccountList[index]["text1"],
                                  fontSize: 14,
                                ),
                                SizedBox(height: 3),
                                CommonTextWidget.InterMedium(
                                  color: grey757,
                                  text: Lists.toBankAccountList[index]["text2"],
                                  fontSize: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 25),
                CommonTextWidget.InterBold(
                  text: "Recents",
                  fontSize: 20,
                  color: grey757,
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Lists.toBankAccountRecentList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => ChatScreen1());
                      },
                      child: Row(
                        children: [
                          Image.asset(
                              Lists.toBankAccountRecentList[index]["image"],
                              height: 45,
                              width: 45),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget.InterSemiBold(
                                text: Lists.toBankAccountRecentList[index]
                                    ["text1"],
                                fontSize: 16,
                                color: black171,
                              ),
                              CommonTextWidget.InterMedium(
                                text: Lists.toBankAccountRecentList[index]
                                    ["text2"],
                                fontSize: 12,
                                color: black171,
                              ),
                              CommonTextWidget.InterRegular(
                                text: Lists.toBankAccountRecentList[index]
                                    ["text3"],
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
