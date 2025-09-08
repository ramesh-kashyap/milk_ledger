import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/profile_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen1 extends StatelessWidget {
  ProfileScreen1({Key? key}) : super(key: key);

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: white),
        ),
        title: CommonTextWidget.InterSemiBold(
          text: "Profile",
          fontSize: 18,
          color: white,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Center(
                child: Image.asset(Images.jason2, height: 115, width: 115),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 160),
            child: Container(
              height: Get.height,
              width: Get.width,
              color: white,
              child: Padding(
                padding: EdgeInsets.only(top: 90, left: 22, right: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTextWidget.InterRegular(
                              text: "Verified name",
                              fontSize: 12,
                              color: grey757,
                            ),
                            CommonTextWidget.InterSemiBold(
                              text: "Jason Adam",
                              fontSize: 16,
                              color: black171,
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        SvgPicture.asset(Images.selectedIcon),
                      ],
                    ),
                    SizedBox(height: 30),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: CommonTextWidget.InterSemiBold(
                        text: "Turn off notifications",
                        fontSize: 14,
                        color: black171,
                      ),
                      subtitle: CommonTextWidget.InterRegular(
                        text: "Stop notifications from this user",
                        fontSize: 12,
                        color: grey757,
                      ),
                      trailing: Obx(
                        () => Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            onChanged: (val) =>
                                profileController.switchIsOpen.toggle(),
                            value: profileController.switchIsOpen.value,
                            activeColor: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: CommonTextWidget.InterSemiBold(
                        text: "Block messages",
                        fontSize: 14,
                        color: black171,
                      ),
                      subtitle: CommonTextWidget.InterRegular(
                        text: "Prevent this user from messaging you",
                        fontSize: 12,
                        color: grey757,
                      ),
                      trailing: Obx(
                        () => Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            onChanged: (val) =>
                                profileController.switchIsOpen1.toggle(),
                            value: profileController.switchIsOpen1.value,
                            activeColor: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CommonTextWidget.InterSemiBold(
                      text: "Report and block this user",
                      fontSize: 14,
                      color: redE50,
                    ),
                    CommonTextWidget.InterRegular(
                      text: "Mark this user as fraud",
                      fontSize: 12,
                      color: redE50,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 130,
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.22),
                    offset: Offset(0, 4),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextWidget.InterBold(
                          text: "Jason Adam",
                          fontSize: 22,
                          color: black171,
                        ),
                        CommonTextWidget.InterMedium(
                          text: "+91 12345 67890",
                          fontSize: 16,
                          color: black171,
                        ),
                        CommonTextWidget.InterRegular(
                          text: "On DigiWallet Since Apr 2021",
                          fontSize: 14,
                          color: grey757,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 28,
                          width: 84,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Image.asset(Images.payRupieeImage),
                          ),
                        ),
                        SizedBox(height: 20),
                        SvgPicture.asset(Images.conversation),
                      ],
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
