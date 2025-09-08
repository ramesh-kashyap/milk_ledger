import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/choose_language_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChooseLanguageScreen extends StatelessWidget {
  ChooseLanguageScreen({Key? key}) : super(key: key);

  final ChooseLanguageController chooseLanguageController =
      Get.put(ChooseLanguageController());
  final List languageList = [
    "English",
    "Gujarati",
    "Hindi",
    "Odia",
    "Marathi",
    "Malayalam",
    "Kannada",
    "Tamil",
    "Telugu",
    "Punjabi",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF9F,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TopIcon Widget View
              TopIconWidgetView(),

              /// List Widget View
              ListViewWidgetView(),
              SizedBox(height: 50),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 40),
            child: CommonButtonWidget.button(
              text: "Continue",
              buttonColor: Colors.green,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  /// TopIcon Widget View
  Widget TopIconWidgetView() {
    return Padding(
      padding: EdgeInsets.only(top: 50, left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, size: 20, color: black171),
          ),
          SizedBox(height: 28),
          CommonTextWidget.InterBold(
            text: "Choose Language",
            fontSize: 20,
            color: black171,
          ),
        ],
      ),
    );
  }

  /// ListView Widget View
  Widget ListViewWidgetView() {
    return GetBuilder<ChooseLanguageController>(
      init: ChooseLanguageController(),
      builder: (controller) => Expanded(
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView.builder(
            itemCount: languageList.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 40),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: () {
                  chooseLanguageController.onIndexChange(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: chooseLanguageController.selectedIndex == index
                            ? Colors.green
                            : white,
                        width: 1.25),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        offset: Offset(0, 5),
                        spreadRadius: 0,
                        color: black.withOpacity(0.05),
                      ),
                    ],
                  ),
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonTextWidget.InterMedium(
                          text: languageList[index],
                          fontSize: 16,
                          color: black0F1,
                        ),
                      SvgPicture.asset(
                            chooseLanguageController.selectedIndex == index
                                ? Images.selectedIcon
                                : Images.unSelectedIcon,
                            height: 25,
                            width: 25),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
