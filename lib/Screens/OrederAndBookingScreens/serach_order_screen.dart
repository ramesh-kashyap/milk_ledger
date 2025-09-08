import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SearchOrderScreen extends StatelessWidget {
  SearchOrderScreen({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back, size: 20, color: black171),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CommonTextFieldWidget.TextFormField2(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child:SvgPicture.asset(Images.search, color: Colors.green),
                    ),
                    keyboardType: TextInputType.text,
                    hintText: "Search",
                    controller: searchController,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                itemCount: Lists.recentOrderList.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: whiteFCF,
                      boxShadow: [
                        BoxShadow(
                          color: black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(Lists.recentOrderList[index]["image"],
                                  height: 40, width: 40),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonTextWidget.InterSemiBold(
                                    text: Lists.recentOrderList[index]["text1"],
                                    fontSize: 14,
                                    color: black171,
                                  ),
                                  CommonTextWidget.InterSemiBold(
                                    text: Lists.recentOrderList[index]["text2"],
                                    fontSize: 12,
                                    color: green2CA,
                                  ),
                                  CommonTextWidget.InterRegular(
                                    text: "11 Apr 2022, 08:07 PM",
                                    fontSize: 12,
                                    color: grey757,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 34,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: whiteF9F,
                              border: Border.all(color: greyE5E, width: 1),
                            ),
                            child: Center(
                              child: CommonTextWidget.InterRegular(
                                text: "Repeat",
                                fontSize: 12,
                                color: Colors.green,
                              ),
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
    );
  }
}
