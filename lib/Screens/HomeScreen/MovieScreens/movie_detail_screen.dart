import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MovieScreens/make_your_calender_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieDetailScreen extends StatelessWidget {
  MovieDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.movieDetailBgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.close, color: white),
                    ),
                  ),
                  Center(
                    child: Image.asset(Images.emaMovieDetailImage,
                        height: 260, width: 240),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget.InterBold(
                        text: "The handmaid’s Ema",
                        fontSize: 30,
                        color: white,
                      ),
                      SizedBox(height: 9),
                      Row(
                        children: [
                          CommonTextWidget.InterRegular(
                            text: "Horror",
                            fontSize: 16,
                            color: white,
                          ),
                          SizedBox(width: 5),
                          CommonTextWidget.InterRegular(
                            text: "\u2022",
                            fontSize: 16,
                            color: white,
                          ),
                          SizedBox(width: 5),
                          CommonTextWidget.InterRegular(
                            text: "18+",
                            fontSize: 16,
                            color: white,
                          ),
                          SizedBox(width: 5),
                          CommonTextWidget.InterRegular(
                            text: "\u2022",
                            fontSize: 16,
                            color: white,
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.star, color: white, size: 10),
                          SizedBox(width: 5),
                          CommonTextWidget.InterRegular(
                            text: "4.5",
                            fontSize: 16,
                            color: white,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: white.withOpacity(0.11),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget.InterRegular(
                                text: "Length",
                                fontSize: 12,
                                color: white,
                              ),
                              SizedBox(height: 6),
                              CommonTextWidget.InterSemiBold(
                                text: "1h 44m",
                                fontSize: 14,
                                color: white,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: white,
                              thickness: 1,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget.InterRegular(
                                text: "Language",
                                fontSize: 12,
                                color: white,
                              ),
                              SizedBox(height: 6),
                              CommonTextWidget.InterSemiBold(
                                text: "Indonesian",
                                fontSize: 14,
                                color: white,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: white,
                              thickness: 1,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextWidget.InterRegular(
                                text: "Review",
                                fontSize: 12,
                                color: white,
                              ),
                              SizedBox(height: 6),
                              CommonTextWidget.InterSemiBold(
                                text: "+44",
                                fontSize: 14,
                                color: white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  Get.bottomSheet(
                    MakeYourCalendarScreen(),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  );
                },
                child: Container(
                  height: 80,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      topLeft: Radius.circular(18),
                    ),
                    color: white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Container(
                        height: 4,
                        width: 48,
                        color: grey8A9,
                      ),
                      SizedBox(height: 15),
                      CommonTextWidget.InterBold(
                        text: "Mark Your Calendar",
                        fontSize: 20,
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
    );
  }
}
