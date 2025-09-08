import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/to_self_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ToSelfScreen extends StatelessWidget {
  ToSelfScreen({Key? key}) : super(key: key);

  final ToSelfController usePayOptionController = Get.put(ToSelfController());

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
        actions: [
          SvgPicture.asset(
            Images.information,
            color: Colors.green,
          ),
          SizedBox(width: 15),
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: SvgPicture.asset(
              Images.setting,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            CommonTextWidget.InterBold(
              text: "Send Money to",
              fontSize: 22,
              color: black171,
            ),
            SizedBox(height: 25),
            CommonTextWidget.InterBold(
              text: "Your Linked Bank Accounts",
              fontSize: 18,
              color: black171,
            ),
            SizedBox(height: 22),
            GetBuilder<ToSelfController>(
              init: ToSelfController(),
              builder: (controller) => ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: Lists.usePayOptionList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () {
                      usePayOptionController.onIndexChange(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: white,
                        border: Border.all(color: greyE5E, width: 1),
                      ),
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: whiteF9F,
                          child: index == 0
                              ? SvgPicture.asset(
                                  Lists.usePayOptionList[index]["image"],
                                  color: Colors.green,
                                )
                              : Image.asset(
                                  Lists.usePayOptionList[index]["image"],
                                  height: 9,
                                  width: 36),
                        ),
                        title: CommonTextWidget.InterSemiBold(
                          text: Lists.usePayOptionList[index]["text1"],
                          fontSize: 16,
                          color: black171,
                        ),
                        subtitle: CommonTextWidget.InterMedium(
                          text: Lists.usePayOptionList[index]["text2"],
                          fontSize: 12,
                          color: index == 0 ? Colors.green : black171,
                        ),
                        trailing: SvgPicture.asset(
                          usePayOptionController.selectedIndex == index
                              ? Images.selectedIcon
                              : Images.unSelectedIcon,
                          height: 25,
                          width: 25,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 22),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                leading: SvgPicture.asset(
                  Images.bankImage,
                  color: Colors.green,
                ),
                title: CommonTextWidget.InterSemiBold(
                  text: "Link New Bank Account",
                  fontSize: 14,
                  color: black171,
                ),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: grey757, size: 20),
              ),
            ),
            Spacer(),
            CommonButtonWidget.button(
              onTap: () {
                Get.back();
              },
              buttonColor: Colors.green,
              text: "Proceed",
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
