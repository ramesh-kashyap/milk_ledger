import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/UserPaymentCodeScreens/my_qrcode_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/AuthScreens/login_screen.dart';

class UserPaymentCodeScreen extends StatefulWidget {
  UserPaymentCodeScreen({Key? key}) : super(key: key);

  @override
  _UserPaymentCodeScreenState createState() => _UserPaymentCodeScreenState();
}

class _UserPaymentCodeScreenState extends State<UserPaymentCodeScreen> {
  String userName = "Loading...";
  String userPhone = "Loading...";
  String userAddress = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    try {
      final response = await ApiService.get("/auth/me");
      final data = response.data;
      if (data["status"] == true) {
        final user = data["user"]; // yaha user ka object aayega
        setState(() {
          userName = user["name"] ?? "Guest User";
          userPhone = user["phone"] ?? "No Phone";
          userAddress = user["address"] ?? "No Address";
        });
      } else {
        // agar success false hoga
        setState(() {
          userName = "Guest rUser";
          userPhone = "No Phone";
          userAddress = "No Address";
        });
      }
    } catch (e) {
      print("Error fetching user profile: $e");
      setState(() {
        userName = "Guest User";
        userPhone = "No Phone";
        userAddress = "No Address";
      });
    }
  }

  Future<void> logout() async {
    try {
      final response = await ApiService.post(
        '/logout',
        {}, // if your backend doesn’t need any body
      );

      if (response.data['status'] == true) {
        // Clear local token/session
        // await LocalStorage.clearToken();
        // Navigate to login page
        Get.offAll(() => LogInScreen());
      } else {
        Get.snackbar('Error', response.data['message'] ?? 'Logout failed');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyEDE,
      appBar: AppBar(
        backgroundColor: greyEDE,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 20, color: black171),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget.InterSemiBold(
                      color: black171,
                      text: userName,
                      fontSize: 26,
                    ),
                    SizedBox(height: 4),
                    CommonTextWidget.InterRegular(
                      color: black171,
                      text: "${'mobile_no'.tr}: $userPhone",
                      fontSize: 12,
                    ),
                    SizedBox(height: 6),
                    CommonTextWidget.InterRegular(
                      color: black171,
                      text: "${'address'.tr}: $userAddress",
                      fontSize: 12,
                    ),
                  ],
                ),
                InkWell(
                  // onTap: () {
                  //   Get.to(() => MyQrCodeScreen());
                  // },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: grey6B7.withOpacity(0.15),
                          offset: Offset(0, 0),
                          blurRadius: 25,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Image.asset("assets/images/cow-avatar.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                color: whiteFBF,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(28),
                  topLeft: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView.builder(
                        padding:
                            const EdgeInsets.only(top: 25, left: 25, right: 25),
                        itemCount: Lists.userQrCodeList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: InkWell(
                            onTap: Lists.userQrCodeList[index]["onTap"],
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(
                                Lists.userQrCodeList[index]["icon"],
                                color: Colors.green,
                                size: 25,
                              ),
                              title: CommonTextWidget.InterBold(
                                color: black171,
                                text: Lists.userQrCodeList[index]["text1"],
                                fontSize: 14,
                              ),
                              subtitle: CommonTextWidget.InterRegular(
                                color: grey757,
                                text: Lists.userQrCodeList[index]["text2"],
                                fontSize: 12,
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  color: grey757, size: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 👇 Logout button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        await logout();
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: Text("logout".tr,
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CommonTextWidget.InterRegular(
                        color: greyA6A,
                         text: "V 1.1.0",
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
