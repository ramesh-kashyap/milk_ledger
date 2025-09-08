import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/home_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_button_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

class CompleteProfileScreen extends StatelessWidget {
  final int userId;
  CompleteProfileScreen({super.key, required this.userId});

  final nameController = TextEditingController();
  final addressController = TextEditingController();

  Future<void> _saveProfile() async {
    try {
      final res = await ApiService.post(
        '/complete-profile',
        {
          "userId": userId,
          "name": nameController.text.trim(),
          "address": addressController.text.trim(),
        },
      );
      if (res.data['status'] == true) {
        if (Get.isBottomSheetOpen ?? false) Get.back();
        Get.offAll(() => HomeScreen());
      } else {
        Get.snackbar('Error', res.data['message'] ?? 'Failed to save profile');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 225),
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
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 25, right: 25, bottom: 8),
                            child: CommonTextWidget.InterBold(
                              color: black171,
                              text: "Cancel",
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.verified_user,
                        size: 100,
                        color: Colors.green,
                      ),
                      SizedBox(height: 28),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: "Full Name",
                              prefixIcon: const Icon(Icons.person_outline,
                                  color: Colors.green),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: addressController,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.home_outlined,
                                  color: Colors.green),
                              hintText: "Enter your address",
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 40, bottom: 25, left: 25, right: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ... permissions text/switches ...
                            const SizedBox(height: 16),
                            CommonButtonWidget.button(
                              text: "Save & Continue",
                              buttonColor: Colors.green,
                              onTap: _saveProfile,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
