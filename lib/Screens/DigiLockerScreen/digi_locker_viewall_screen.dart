import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/DigiLockerScreen/digi_locker_search_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DigiLockerViewAllScreen extends StatelessWidget {
  DigiLockerViewAllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
        title: CommonTextWidget.InterSemiBold(
          text: "Central Government",
          fontSize: 18,
          color: black171,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: InkWell(
              onTap: () {
                Get.to(() => DigiLockerSearchScreen());
              },
              child:SvgPicture.asset(Images.search),
            ),
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 15,
            crossAxisSpacing: 10,
            childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2 /1.3,
          ),
          shrinkWrap: true,
          primary: false,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 25,left: 22,right: 22,bottom: 5),
          itemCount: Lists.digiLockerViewAllList.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Lists.digiLockerViewAllList[index]["image"],
                      height: 75,
                      width: 75,
                    ),
                    SizedBox(height: 12),
                    CommonTextWidget.InterSemiBold(
                        color: black171,
                        text: Lists.digiLockerViewAllList[index]["text"],
                        fontSize: 14,
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
