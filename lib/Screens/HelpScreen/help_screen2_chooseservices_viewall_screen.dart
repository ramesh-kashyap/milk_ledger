import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HelpScreen/help_screen4.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HelpScreen2ChooseServicesViewAllScreen extends StatelessWidget {
  HelpScreen2ChooseServicesViewAllScreen({Key? key}) : super(key: key);

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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20,right: 20,bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterBold(
                      text: "Choose a service to begin",
                      fontSize: 18,
                      color: black171,
                    ),
                    Icon(CupertinoIcons.search, color: black171, size: 18),
                  ],
                ),
                SizedBox(height: 10),
                ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio:
                          MediaQuery.of(context).size.aspectRatio * 2 / 1.2,
                    ),
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: Lists.chooseServicesList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => HelpScreen4());
                        },
                        child: Container(
                          height: 170,
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
                                      child:SvgPicture.asset(Lists
                                          .chooseServicesList[index]["image"],color: Colors.green,),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 9),
                                CommonTextWidget.InterSemiBold(
                                  color: black171,
                                  text: Lists.chooseServicesList[index]
                                      ["text1"],
                                  fontSize: 14,
                                ),
                                SizedBox(height: 3),
                                CommonTextWidget.InterRegular(
                                  color: grey757,
                                  text: Lists.chooseServicesList[index]
                                      ["text2"],
                                  fontSize: 11,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
