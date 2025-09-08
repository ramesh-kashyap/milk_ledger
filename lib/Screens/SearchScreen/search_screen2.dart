import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SearchScreen2 extends StatelessWidget {
  SearchScreen2({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            color: greyF5F,
            child: Padding(
              padding:
                  EdgeInsets.only(top: 50, left: 22, right: 22, bottom: 25),
              child: TextFormField(
                keyboardType: TextInputType.text,
                cursorColor: Colors.green,
                controller: searchController,
                style: TextStyle(
                  color: black171,
                  fontSize: 14,
                  fontFamily: FontFamily.InterSemiBold,
                ),
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: greyA6A,
                    fontSize: 16,
                    fontFamily: FontFamily.InterRegular,
                  ),
                  prefixIcon: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back, size: 20, color: black171),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child:SvgPicture.asset(Images.search),
                  ),
                  filled: true,
                  fillColor: white,
                  contentPadding: EdgeInsets.zero,
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: white, width: 0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: white, width: 0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: white, width: 0)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: white, width: 0)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: white, width: 0)),
                ),
              ),
            ),
          ),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 30, left: 22, right: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget.InterRegular(
                      text: "Popular Tags ",
                      color: black171,
                      fontSize: 19,
                    ),
                    SizedBox(height: 15),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio:
                            MediaQuery.of(context).size.aspectRatio * 2 / 0.4,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: Lists.popularTagsList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: grey979),
                            color: white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTextWidget.InterRegular(
                                text: Lists.popularTagsList[index]["text"],
                                color: grey757,
                                fontSize: 12,
                                textAlign: TextAlign.center,
                              ),
                              Icon(Icons.close, size: 10, color: grey757),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonTextWidget.InterRegular(
                          text: "Recently Search",
                          color: black171,
                          fontSize: 19,
                        ),
                        CommonTextWidget.InterSemiBold(
                          text: "Delete all",
                          color: grey757,
                          fontSize: 14,
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: 4,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonTextWidget.InterSemiBold(
                                text: "Joker : Put on a happies",
                                color: black171,
                                fontSize: 19,
                              ),
                              Icon(Icons.close, size: 15, color: black171),
                            ],
                          ),
                          SizedBox(height: 22),
                          Divider(thickness: 1, color: greyDEE),
                          SizedBox(height: 22),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
