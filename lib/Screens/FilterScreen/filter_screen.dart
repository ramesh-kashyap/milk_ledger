import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/filter_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({Key? key}) : super(key: key);

  final FilterController filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 250),
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
                padding:
                    EdgeInsets.only(top: 28, bottom: 30, left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonTextWidget.InterSemiBold(
                          text: "Filter",
                          fontSize: 18,
                          color: black171,
                        ),
                        Container(
                          height: 32,
                          width: 105,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: blueEEE,
                          ),
                          child: Center(
                            child: CommonTextWidget.InterMedium(
                              text: "Clear Filter",
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CommonTextWidget.InterSemiBold(
                      text: "Sort Orders by",
                      fontSize: 16,
                      color: black0D0,
                    ),
                    SizedBox(height: 25),
                    SizedBox(
                      height: 42,
                      width: Get.width,
                      child: GetBuilder<FilterController>(
                        init: FilterController(),
                        builder: (controller) => ListView.builder(
                          shrinkWrap: true,
                          itemCount: Lists.sortOrderList.length,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: InkWell(
                              onTap: () {
                                filterController.onIndexChange(index);
                              },
                              child: Container(
                                height: 42,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                      color: filterController.selectedIndex ==
                                              index
                                          ? blueEEE
                                          : greyE5E,
                                      width: 1),
                                  color: filterController.selectedIndex == index
                                      ? blueEEE
                                      : white,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 12),
                                    child: CommonTextWidget.InterMedium(
                                      text: Lists.sortOrderList[index],
                                      fontSize: 14,
                                      color: filterController.selectedIndex ==
                                              index
                                          ? Colors.green
                                          : black0D0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CommonTextWidget.InterSemiBold(
                      text: "Show Orders By Time",
                      fontSize: 16,
                      color: black0D0,
                    ),
                    SizedBox(height: 20),
                    GetBuilder<FilterController>(
                      init: FilterController(),
                      builder: (controller) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: Lists.showOrderList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonTextWidget.InterRegular(
                                text: Lists.showOrderList[index],
                                fontSize: 14,
                                color: black0D0,
                              ),
                              InkWell(
                                onTap: () {
                                  filterController.onIndexChange1(index);
                                },
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            filterController.selectedIndex1 ==
                                                    index
                                                ? Colors.green
                                                : greyA6A,
                                        width: 2),
                                    color: white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.check,
                                        color:
                                            filterController.selectedIndex1 ==
                                                    index
                                                ? Colors.green
                                                : white,
                                        size: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    CommonButtonWidget.button(
                      text: "Apply",
                      buttonColor: Colors.green,
                      onTap: () {
                        Get.back();
                      },
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
