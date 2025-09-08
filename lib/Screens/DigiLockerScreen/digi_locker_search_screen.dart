import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DigiLockerSearchScreen extends StatelessWidget {
  DigiLockerSearchScreen({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 15),
            child: CommonTextWidget.InterBold(
              text: "Most Popular",
              fontSize: 16,
              color: black171,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 22),
            physics: NeverScrollableScrollPhysics(),
            itemCount: Lists.digiLockerSearchList.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: greyE5E, width: 1),
                ),
                child: ListTile(
                  title: CommonTextWidget.InterSemiBold(
                    text: Lists.digiLockerSearchList[index]["text1"],
                    fontSize: 14,
                    color: black171,
                  ),
                  subtitle: CommonTextWidget.InterRegular(
                    text: Lists.digiLockerSearchList[index]["text2"],
                    fontSize: 12,
                    color: grey6A7,
                  ),
                  trailing:
                      Icon(Icons.arrow_forward_ios, color: grey757, size: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
