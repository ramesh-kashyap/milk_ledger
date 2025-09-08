import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MovieScreens/movie_detail_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/SearchScreen/search_screen2.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MovieTicketScreen extends StatelessWidget {
  MovieTicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
        title: Image.asset(Images.movieTicketTitleImage, height: 16, width: 75),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 22),
            child: Container(
              height: 40,
              width: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.04),
                    offset: Offset(0, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonTextWidget.InterRegular(
                    text: "Delhi/NCR",
                    fontSize: 15,
                    color: black171,
                  ),
                  SizedBox(width: 7),
                SvgPicture.asset(Images.arrowDownIcon),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "What would you like \nto see today? ",
                        style: TextStyle(
                          fontFamily: FontFamily.InterBold,
                          fontSize: 22,
                          color: black171,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Popular",
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: FontFamily.InterBold,
                              color: Colors.green,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 7),
                  SvgPicture.asset(Images.arrowDownIcon, color: Colors.green),
                  ],
                ),
                InkWell(
                    onTap: () {
                      Get.to(() => SearchScreen2());
                    },
                    child:SvgPicture.asset(Images.search)),
              ],
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            height: 260,
            width: Get.width,
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                itemCount: Lists.moviesList.length,
                padding: EdgeInsets.only(left: 22),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => MovieDetailScreen());
                    },
                    child: Container(
                      height: 260,
                      width: 205,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        image: DecorationImage(
                          image: AssetImage(Lists.moviesList[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 35),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonTextWidget.InterSemiBold(
                  text: "Popular Actor’s ",
                  fontSize: 19,
                  color: black171,
                ),
                CommonTextWidget.InterSemiBold(
                  text: "See all",
                  fontSize: 14,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            height: 120,
            width: Get.width,
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                itemCount: Lists.movies2List.length,
                padding: EdgeInsets.only(left: 22),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right: 22),
                  child: Column(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          image: DecorationImage(
                            image: AssetImage(
                              Lists.movies2List[index]["image"],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      CommonTextWidget.InterRegular(
                        text: Lists.movies2List[index]["text"],
                        fontSize: 12,
                        color: black171,
                        textAlign: TextAlign.center,
                      ),
                    ],
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
