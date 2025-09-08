import 'package:carousel_slider/carousel_slider.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/font_family.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/digiwallet_postpaid_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_textfeild_widget.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DigiwalletPostPaidScreen extends StatelessWidget {
  DigiwalletPostPaidScreen({Key? key}) : super(key: key);
  final DigiWalletPostPaidController digiWalletPostPaidController =
      Get.put(DigiWalletPostPaidController());
  final TextEditingController enterPanController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: blueEFE,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
        title:SvgPicture.asset(Images.digiWalletPostPaidTitleImage),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.digiWalletPostpaidBgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  CarouselSlider.builder(
                    itemCount: 3,
                    itemBuilder:
                        (BuildContext context, index, int pageViewIndex) =>
                            Container(
                      height: 125,
                      width: Get.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage(Images.digiWalletPostPaidSliderImage),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        initialPage: 3,
                        viewportFraction: 0.9,
                        onPageChanged: (index, reason) {
                          digiWalletPostPaidController.selectedIndex.value =
                              index;
                        }),
                  ),
                  // SizedBox(height: 12),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 3; i++)
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Container(
                                height: 6,
                                width: i ==
                                        digiWalletPostPaidController
                                            .selectedIndex.value
                                    ? 16
                                    : 6,
                                decoration: BoxDecoration(
                                    color: i ==
                                            digiWalletPostPaidController
                                                .selectedIndex.value
                                        ? Colors.green
                                        : black.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(9))),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: CommonTextWidget.InterSemiBold(
                      text: "Activate Postpaid at Zero\nJoining Fee",
                      fontSize: 20,
                      color: black171,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 28),
                  CommonTextWidget.InterSemiBold(
                    text: "Enter Details",
                    fontSize: 16,
                    color: black171,
                  ),
                  SizedBox(height: 15),
                  CommonTextFieldWidget.TextFormField3(
                    controller: enterPanController,
                    hintText: "Enter PAN",
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  CommonTextFieldWidget.TextFormField3(
                    controller: dateController,
                    hintText: "Date of Birth (DD/MM/YYYY)",
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  CommonTextFieldWidget.TextFormField3(
                    controller: emailController,
                    hintText: "Email",
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => InkWell(
                          onTap: () {
                            digiWalletPostPaidController.select.value =
                                !digiWalletPostPaidController.select.value;
                          },
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              color: digiWalletPostPaidController.select.isTrue
                                  ? Colors.green
                                  : white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color:
                                      digiWalletPostPaidController.select.isTrue
                                          ? Colors.green
                                          : greyDCD,
                                  width: 1),
                            ),
                            child: Center(
                              child: Icon(Icons.check, color: white, size: 10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: "I agree to ",
                            style: TextStyle(
                              fontFamily: FontFamily.InterRegular,
                              fontSize: 12,
                              color: black171,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Terms and Conditions & Privacy Policy. ",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: FontFamily.InterRegular,
                                    color: Colors.green),
                              ),
                              TextSpan(
                                text:
                                    "I authorize One97 to access my credit report from credit bureaus and store it to process my Personal Loan Application.",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: FontFamily.InterRegular,
                                    color: black171),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  CommonButtonWidget.button(
                    onTap: () {},
                    buttonColor: Colors.green,
                    text: "Activate Now",
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
