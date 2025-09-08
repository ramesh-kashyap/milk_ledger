import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/use_pay_option_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UsePayOptionScreen extends StatelessWidget {
  UsePayOptionScreen({Key? key}) : super(key: key);

  final UsePayOptionController usePayOptionController =
      Get.put(UsePayOptionController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 200),
      child: Column(
        children: [
          Container(
            height: 6,
            width: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: white,
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget.InterBold(
                      text: "Pay Using",
                      fontSize: 20,
                      color: black171,
                    ),
                    SizedBox(height: 22),
                    GetBuilder<UsePayOptionController>(
                      init: UsePayOptionController(),
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
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 15),
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: whiteF9F,
                                  child: index == 0
                                      ?SvgPicture.asset(Lists
                                          .usePayOptionList[index]["image"])
                                      : Image.asset(
                                          Lists.usePayOptionList[index]
                                              ["image"],
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
                                trailing:SvgPicture.asset(
                                    usePayOptionController.selectedIndex ==
                                            index
                                        ? Images.selectedIcon
                                        : Images.unSelectedIcon,
                                    height: 25,
                                    width: 25),
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
                        leading:SvgPicture.asset(Images.bankImage),
                        title: CommonTextWidget.InterSemiBold(
                          text: "New Bank Account",
                          fontSize: 14,
                          color: black171,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: grey757, size: 20),
                      ),
                    ),
                    Spacer(),
                    CommonButtonWidget.button(
                      onTap: () {
                        Get.back();
                      },
                      buttonColor: Colors.green,
                      text: "Confirm",
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
