import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HelpScreen2PopularHelpViewAllScreen extends StatelessWidget {
   HelpScreen2PopularHelpViewAllScreen({Key? key}) : super(key: key);

   final TextEditingController searchController = TextEditingController();

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
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CommonTextFieldWidget.TextFormField2(
              prefixIcon: Padding(
                padding: EdgeInsets.all(15),
                child:SvgPicture.asset(Images.search, color: Colors.green),
              ),
              keyboardType: TextInputType.text,
              hintText: "Search",
              controller: searchController,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: Lists.popularHelpList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 10),
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
                        padding:
                        EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                        child: Row(
                          children: [
                          SvgPicture.asset(
                              Lists.popularHelpList[index]["image"],
                               color: Colors.green,
                            ),
                            SizedBox(width: 22),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTextWidget.InterSemiBold(
                                    text: Lists.popularHelpList[index]["text1"],
                                    fontSize: 14,
                                    color: black171,
                                  ),
                                  CommonTextWidget.InterRegular(
                                    text: Lists.popularHelpList[index]["text2"],
                                    fontSize: 12,
                                    color: grey757,
                                  ),
                                  CommonTextWidget.InterSemiBold(
                                    text: Lists.popularHelpList[index]["text3"],
                                    fontSize: 12,
                                    color: Colors.green,
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
          ],
        ),
      ),
    );
  }
}
