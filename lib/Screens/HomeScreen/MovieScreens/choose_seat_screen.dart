import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MovieScreens/ticket_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseSeatScreen extends StatelessWidget {
  ChooseSeatScreen({Key? key}) : super(key: key);

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
                      text: "Choose Seat",
                      fontSize: 20,
                      color: black171,
                    ),
                    SizedBox(height: 22),
                    Divider(thickness: 1, color: greyDEE),
                    SizedBox(height: 20),
                    Image.asset(Images.bioskopImage, height: 135, width: 330),
                    SizedBox(height: 25),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 14,
                                childAspectRatio:
                                    MediaQuery.of(context).size.aspectRatio *
                                        2 /
                                        0.8,
                              ),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: 24,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: index == 0 ||
                                            index == 1 ||
                                            index == 2 ||
                                            index == 3 ||
                                            index == 5 ||
                                            index == 7 ||
                                            index == 9 ||
                                            index == 13 ||
                                            index == 17 ||
                                            index == 18 ||
                                            index == 21 ||
                                            index == 22
                                        ? white
                                        : index == 11 ||
                                                index == 15 ||
                                                index == 19 ||
                                                index == 23
                                            ? Colors.green
                                            : greyD4D,
                                    border: index == 2 ||
                                            index == 3 ||
                                            index == 5 ||
                                            index == 7 ||
                                            index == 9 ||
                                            index == 13 ||
                                            index == 17 ||
                                            index == 18 ||
                                            index == 21 ||
                                            index == 22
                                        ? Border.all(width: 1, color: greyBFD)
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 35),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 14,
                                childAspectRatio:
                                    MediaQuery.of(context).size.aspectRatio *
                                        2 /
                                        0.8,
                              ),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: 24,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: index == 0 ||
                                            index == 1 ||
                                            index == 2 ||
                                            index == 3 ||
                                            index == 4 ||
                                            index == 5 ||
                                            index == 7 ||
                                            index == 9 ||
                                            index == 10 ||
                                            index == 11 ||
                                            index == 13 ||
                                            index == 15 ||
                                            index == 17 ||
                                            index == 19 ||
                                            index == 23
                                        ? white
                                        : index == 12 ||
                                                index == 16 ||
                                                index == 20
                                            ? Colors.green
                                            : greyD4D,
                                    border: index == 0 ||
                                            index == 1 ||
                                            index == 4 ||
                                            index == 5 ||
                                            index == 6 ||
                                            index == 7 ||
                                            index == 9 ||
                                            index == 10 ||
                                            index == 11 ||
                                            index == 13 ||
                                            index == 15 ||
                                            index == 17 ||
                                            index == 19 ||
                                            index == 23
                                        ? Border.all(width: 1, color: greyBFD)
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18),
                    Divider(thickness: 1, color: greyDEE),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: black171),
                              SizedBox(width: 12),
                              CommonTextWidget.InterSemiBold(
                                text: "XXI Ambarukmo Plaza",
                                fontSize: 20,
                                color: black171,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Column(
                                children: [
                                  CommonTextWidget.InterRegular(
                                    text: "Date",
                                    fontSize: 15,
                                    color: black171,
                                  ),
                                  SizedBox(height: 6),
                                  CommonTextWidget.InterMedium(
                                    text: "20 Nov",
                                    fontSize: 20,
                                    color: black171,
                                  ),
                                ],
                              ),
                              SizedBox(width: 15),
                              SizedBox(
                                height: 30,
                                child: VerticalDivider(
                                  color: black171,
                                  thickness: 0.3,
                                ),
                              ),
                              SizedBox(width: 15),
                              Column(
                                children: [
                                  CommonTextWidget.InterRegular(
                                    text: "Hour",
                                    fontSize: 15,
                                    color: black171,
                                  ),
                                  SizedBox(height: 6),
                                  CommonTextWidget.InterMedium(
                                    text: "15:05",
                                    fontSize: 20,
                                    color: black171,
                                  ),
                                ],
                              ),
                              SizedBox(width: 15),
                              SizedBox(
                                height: 30,
                                child: VerticalDivider(
                                  color: black171,
                                  thickness: 0.3,
                                ),
                              ),
                              SizedBox(width: 15),
                              Column(
                                children: [
                                  CommonTextWidget.InterRegular(
                                    text: "Seats",
                                    fontSize: 15,
                                    color: black171,
                                  ),
                                  SizedBox(height: 6),
                                  CommonTextWidget.InterMedium(
                                    text: "A02",
                                    fontSize: 20,
                                    color: black171,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          CommonTextWidget.InterMedium(
                            text: "Total Price",
                            fontSize: 15,
                            color: black171,
                          ),
                          SizedBox(height: 2),
                          CommonTextWidget.InterSemiBold(
                            text: "Rs. 300",
                            fontSize: 30,
                            color: Colors.green,
                          ),
                          SizedBox(height: 16),
                          CommonTextWidget.InterRegular(
                            text:
                                "Children (2 years old or above) are required to purchase ticket.",
                            fontSize: 10,
                            color: grey757,
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
                    text: "Pay Now",
                    buttonColor: Colors.green,
                    onTap: () {
                      Get.to(() => TicketScreen());
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
