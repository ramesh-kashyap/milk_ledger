import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/select_your_calender_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MovieScreens/choose_seat_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MakeYourCalendarScreen extends StatelessWidget {
  MakeYourCalendarScreen({Key? key}) : super(key: key);

  final SelectYourCalenderController selectYourCalenderController =
      Get.put(SelectYourCalenderController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 70),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(18),
            topLeft: Radius.circular(18),
          ),
          color: white,
        ),
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
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
                    SizedBox(height: 22),
                    Divider(thickness: 1, color: greyDEE),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CalendarTimeline(
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              Duration(days: 365 * 4),
                            ),
                            onDateSelected: (date) => print(date),
                            leftMargin: 0,
                            monthColor: white,
                            dayColor: black171,
                            activeDayColor: white,
                            dayNameColor: white,
                            activeBackgroundDayColor: Colors.green,
                            // dotsColor: Colors.green,
                            selectableDayPredicate: (date) => date.day != 23,
                            locale: 'en',
                          ),
                          SizedBox(height: 30),
                          CommonTextWidget.InterRegular(
                            text: "Select Cinema",
                            fontSize: 10,
                            color: black171,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonTextWidget.InterSemiBold(
                                text: "Cinema XXI Ambarukm Plaza",
                                fontSize: 15,
                                color: black171,
                              ),
                            SvgPicture.asset(Images.arrowDownIcon),
                            ],
                          ),
                          SizedBox(height: 8),
                          Divider(thickness: 1, color: greyDEE),
                          SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonTextWidget.InterSemiBold(
                                text: "REGULAR 2D",
                                fontSize: 15,
                                color: black171,
                              ),
                              CommonTextWidget.InterRegular(
                                text: "Rs. 300",
                                fontSize: 15,
                                color: black171,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          GetBuilder<SelectYourCalenderController>(
                            init: SelectYourCalenderController(),
                            builder: (controller) => GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 10,
                                childAspectRatio:
                                    MediaQuery.of(context).size.aspectRatio *
                                        2 /
                                        0.8,
                              ),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: Lists.selectYourCalenderList.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.onIndexChange(index);
                                          selectYourCalenderController
                                              .selectedIndex.value = true;
                                        },
                                        child: Container(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            color:
                                                controller.selectedIndex == index
                                                    ? Colors.green
                                                    : white,
                                            border: Border.all(
                                              color: controller.selectedIndex ==
                                                      index
                                                  ? Colors.green
                                                  : grey979.withOpacity(0.38),
                                              width: 0.5,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            child: Column(
                                              children: [
                                                CommonTextWidget.InterBold(
                                                  text: Lists
                                                          .selectYourCalenderList[
                                                      index]["text1"],
                                                  color:
                                                      controller.selectedIndex ==
                                                              index
                                                          ? white
                                                          : Colors.green,
                                                  fontSize: 14,
                                                ),
                                                SizedBox(height: 5),
                                                CommonTextWidget.InterRegular(
                                                  text: Lists
                                                          .selectYourCalenderList[
                                                      index]["text2"],
                                                  color:
                                                      controller.selectedIndex ==
                                                              index
                                                          ? white
                                                          : black171,
                                                  fontSize: 10,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      CommonTextWidget.InterMedium(
                                        text: "Recliner",
                                        fontSize: 10,
                                        color: grey757,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonTextWidget.InterSemiBold(
                                text: "Cinema XXI Ambarukm Plaza",
                                fontSize: 15,
                                color: black171,
                              ),
                            SvgPicture.asset(Images.arrowDownIcon),
                            ],
                          ),
                          SizedBox(height: 8),
                          Divider(thickness: 1, color: greyDEE),
                          SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonTextWidget.InterSemiBold(
                                text: "REGULAR 2D",
                                fontSize: 15,
                                color: black171,
                              ),
                              CommonTextWidget.InterRegular(
                                text: "Rs. 300",
                                fontSize: 15,
                                color: black171,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          GetBuilder<SelectYourCalenderController>(
                            init: SelectYourCalenderController(),
                            builder: (controller) => GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 10,
                                childAspectRatio:
                                    MediaQuery.of(context).size.aspectRatio *
                                        2 / 0.8,
                              ),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: Lists.selectYourCalenderList.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller.onIndexChange1(index);
                                          selectYourCalenderController
                                              .selectedIndex1.value = true;
                                        },
                                        child: Container(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            color:
                                                controller.selectedIndex1 == index
                                                    ? Colors.green
                                                    : white,
                                            border: Border.all(
                                              color: controller.selectedIndex1 ==
                                                      index
                                                  ? Colors.green
                                                  : grey979.withOpacity(0.38),
                                              width: 0.5,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 6),
                                            child: Column(
                                              children: [
                                                CommonTextWidget.InterBold(
                                                  text: Lists
                                                          .selectYourCalenderList[
                                                      index]["text1"],
                                                  color:
                                                      controller.selectedIndex1 ==
                                                              index
                                                          ? white
                                                          : Colors.green,
                                                  fontSize: 14,
                                                ),
                                                SizedBox(height: 5),
                                                CommonTextWidget.InterRegular(
                                                  text: Lists
                                                          .selectYourCalenderList[
                                                      index]["text2"],
                                                  color:
                                                      controller.selectedIndex1 ==
                                                              index
                                                          ? white
                                                          : black171,
                                                  fontSize: 10,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      CommonTextWidget.InterMedium(
                                        text: "Recliner",
                                        fontSize: 10,
                                        color: grey757,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: black354.withOpacity(0.19),
                      blurRadius: 64,
                      offset: Offset(0, -13),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: CommonButtonWidget.button(
                    text: "Take a Seat",
                    buttonColor: Colors.green,
                    onTap: () {
                      Get.bottomSheet(
                        ChooseSeatScreen(),
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                      );
                    },
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
