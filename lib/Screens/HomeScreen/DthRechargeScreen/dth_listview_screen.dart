import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/DthRechargeScreen/enter_dth_recharge_detail_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DthListviewScreen extends StatelessWidget {
  DthListviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: Lists.selectDthOperatorList.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () {
              Get.to(()=>EnterDthRechargeDetailScreen());
            },
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                border: Border.all(color: greyE5E, width: 1),
                borderRadius: BorderRadius.circular(16),
                color: white,
              ),
              child: ListTile(
                leading: Image.asset(Lists.selectDthOperatorList[index]["image"],
                    height: 45, width: 45),
                title: CommonTextWidget.InterSemiBold(
                  text: Lists.selectDthOperatorList[index]["text"],
                  fontSize: 16,
                  color: black171,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
