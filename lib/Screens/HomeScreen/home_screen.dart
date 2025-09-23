import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Controllers/banner_controller.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/add_customer_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/customers_list_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/to_bank_account_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/to_mobile_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/to_self_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ScannerScreen/scanner_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/pay_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/daily_dairy_report.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/dairy_sale_report.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/view_transection.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/daily_purchase_report.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/payment_slip_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/report_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/customer_onoff.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/add_Product_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/dairy_product_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/setting_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/milk_rate_settings_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/milk_entry_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/pay_receive_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/UserPaymentCodeScreens/user_payment_code_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/lists_view.dart';
import 'package:digitalwalletpaytmcloneapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "Loading...";
  final BannerSliderController bannerSliderController =
      Get.put(BannerSliderController());

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  void fetchUserName() async {
    print("Fetching user profile...");

    try {
      final response = await ApiService.get("/auth/me");

      final data = response.data;

      if (data["status"] == true) {
        final user = data["user"];
        setState(() {
          userName = user["name"] ?? "Name User";
        });
      } else {
        setState(() {
          userName = "Guest User";
        });
      }
    } catch (e) {
      print("Error fetching user profile: $e");
      setState(() {
        userName = "Guest User";
      });
    }
  }

  Future<String?> _selectCustomerType(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("select_customer_type".tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: Colors.green),
              title: Text("seller".tr),
              onTap: () => Navigator.pop(ctx, "Seller"),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
             title: Text("purchaser".tr),
              onTap: () => Navigator.pop(ctx, "Purchaser"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF9F,
      body: Stack(
        children: [
          Column(
            children: [
              /// TopContainer Widget View
              TopContainerWidgetView(),

              /// MyDigiWallet Widget View
              BodyWidgetView(context),
            ],
          ),

          /// TopContainer2 Widget View
          TopContainer2WidgetView(),

          /// Bottom Image Widget View
          // BottomImageWidgetView(),
        ],
      ),
    );
  }

  String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return "good_morning".tr;      // ✅ use translation keys
  } else if (hour < 17) {
    return "good_afternoon".tr;
  } else {
    return "good_evening".tr;
  }
}


  /// TopContainer Widget View
  Widget TopContainerWidgetView() {
    return Container(
      height: 190,
      width: Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/cow.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 40),
        child: ListTile(
          horizontalTitleGap: 0,
          leading: InkWell(
            onTap: () {
              Get.to(() => UserPaymentCodeScreen());
            },
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.black, size: 28),
              onPressed: () {
                Get.to(() => UserPaymentCodeScreen());
              },
            ),
          ),
          title: InkWell(
            onTap: () {
              Get.to(() => UserPaymentCodeScreen());
            },
            child: CommonTextWidget.InterMedium(
              color: black171,
              text: getGreeting(),
              fontSize: 12,
            ),
          ),
          subtitle: InkWell(
            onTap: () {
              Get.to(() => UserPaymentCodeScreen());
            },
            child: CommonTextWidget.InterBold(
              color: black171,
              text: "hello_user".trParams({"name": userName}),
              fontSize: 20,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Share.share(
                    'Check out DoodhBazaar! Download now: https://play.google.com/store/apps/details?id=com.example.DoodhBazaar',
                    subject: 'DoodhBazaar App',
                  );
                },
                child: Icon(
                  Icons.share,
                  color: Colors.black, // match your theme
                  size: 28, // adjust size if needed
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// TopContainer2 Widget View
  Widget TopContainer2WidgetView() {
    return Positioned(
      top: 145,
      left: 20,
      right: 20,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.22),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => MilkEntryScreen());
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/milk-48.png",
                      width: 40,
                      height: 40,
                    ),
                    CommonTextWidget.InterSemiBold(
                      color: black171,
                      text: "milk_entry".tr,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => PayReceiveScreen());
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/pay-50.png",
                      width: 40,
                      height: 40,
                    ),
                    CommonTextWidget.InterSemiBold(
                      color: black171,
                      text: "pay_receive".tr,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ToSelfScreen());
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/icons8-report-48.png",
                      width: 40,
                      height: 40,
                    ),
                    CommonTextWidget.InterSemiBold(
                      color: black171,
                      text: "reports".tr,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  final type = await _selectCustomerType(context);
                  if (type != null) {
                    Get.to(() => AddCustomerScreen(customerType: type));
                  }
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/icons8-customer-80.png",
                      width: 40,
                      height: 40,
                    ),
                    CommonTextWidget.InterSemiBold(
                      color: black171,
                      text: "customer".tr,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Body Widget View
  Widget BodyWidgetView(context) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              /// MyDigiWallet Widget View
              Padding(
                padding:
                    EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterBold(
                      color: black171,
                      text: "my_dairy_data".tr,
                      fontSize: 18,
                    ),
                    CommonTextWidget.InterRegular(
                      color: grey757,
                      text: "1234567890@paytm",
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BigFeatureTile(
                  iconAsset: "assets/images/milk-48.png",
                  title: "milk_collection".tr,
                  subtitle: "sell_purchase".tr,
                  onTap: () {
                    // navigate to milk collection screen

                    Get.to(() =>  MilkEntryScreen());
                  },
                ),
              ),

              SizedBox(height: 10),

              // Outer padding once for the row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, // <- important
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
  child: GestureDetector(
    onTap: () {
      Get.to(() =>  PayScreen());
    },
    child: OutlineTile(
      iconAsset: "assets/images/icons8-bill-80.png",
      title: "bill".tr,
      subtitle: "customer_bills".tr,
    ),
  ),
),

                    const SizedBox(width: 8), // <- only middle gap
                    Expanded(
                      child: OutlineTile(
                        // no margin here either
                        iconAsset: "assets/images/icons8-product-48.png",
                        title: "products".tr,
                        subtitle: "daily_products".tr,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Outer padding once for the row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, // <- important
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: OutlineTile(
                        // no margin inside this widget
                        iconAsset: "assets/images/icons8-bill-80.png",
                        title: "report".tr,
                        subtitle: "dairy_reports".tr,
                      ),
                    ),
                    const SizedBox(width: 8), // <- only middle gap
                    Expanded(
                      child: OutlineTile(
                        // no margin here either
                        iconAsset: "assets/images/icons8-product-48.png",
                        title: "pay/receive".tr,
                        subtitle: "amount_entries".tr,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BigFeatureTile(
                  iconAsset: "assets/images/icons8-customer-80.png",
                  title: "all_customers".tr,
                  subtitle: "seller_purchase".tr,
                  onTap: () {
                    // navigate to milk collection screen
                    Get.to(() =>  CustomersListScreen());
                  },
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BigFeatureTile(
                  iconAsset: "assets/images/icons8-report-48.png",
                  title: "view_transactions".tr,
                  subtitle: "payment_details".tr,
                  onTap: () {
                   Get.to(() =>  TransactionPage());
                  },
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BigFeatureTile(
                  iconAsset: "assets/images/icons8-buy-48.png",
                  title: "daily_purchase_report".tr,
                  subtitle: "purchase_details".tr,
                  onTap: () {
                    Get.to(() =>  DailyPurchaseReportScreen());
                  },
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BigFeatureTile(
                  iconAsset: "assets/images/icons8-product-48.png",
                  title: "dairy_report".tr,
                  subtitle: "sale_details".tr,
                  onTap: () {
                      Get.to(() =>  DairyReportScreen());
                  },
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BigFeatureTile(
                  iconAsset: "assets/images/icons8-pie-chart-report-50.png",
                  title: "daily_sale_report".tr,
                  subtitle: "sale_details".tr,
                  onTap: () {
                      Get.to(() =>  DailySaleReportScreen());
                  },
                ),
              ),

               SizedBox(height: 10),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BigFeatureTile(
                  iconAsset: "assets/images/icons8-buy-48.png",
                  title: "dairy_products".tr,
                  subtitle: "ghee_dahi_lassi".tr,
                  onTap: () {
                    Get.to(() =>  DairyProductsScreen());
                  },
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BigFeatureTile(
                  iconAsset: "assets/images/icons8-customer-64.png",
                  title: "customer_on_off".tr,
                  subtitle: "enable_disable_customer".tr,
                  onTap: () {
                    Get.to(() =>  CustomerOnOffScreen());
                  },
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BigFeatureTile(
                  iconAsset: "assets/images/icons8-purchase-order-80.png",
                  title: "payment_slips".tr,
                  subtitle: "manage_payment_slips".tr,
                  onTap: () {
                    Get.to(() =>  PaymentScreen());
                  },
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BigFeatureTile(
                  iconAsset: "assets/images/icons8-purchase-order-80.png",
                  title: "report".tr,
                  subtitle: "buyer_seller_report".tr,
                  onTap: () {
                    Get.to(() =>  ReportScreen());
                  },
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BigFeatureTile(
                  iconAsset: "assets/images/icons8-setting-50.png",
                  title: "milk_rate_settings".tr,
                  subtitle: "change_milk_rates".tr,
                  onTap: () {
                    // Get.to(()=> const SettingsPage());
                  },
                ),
              ),

              SizedBox(height: 15),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BigFeatureTile(
                  iconAsset: "assets/images/icons8-setting-50.png",
                  title: "settings".tr,
                  subtitle: "language_bill_duration".tr,
                  onTap: () {
                    Get.to(()=> const SettingsPage());
                  },
                ),
              ),

              SizedBox(height: 15),

              /// Insurance Widget View
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTextWidget.InterBold(
                      color: black171,
                      text: "quick_actions".tr,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1),

              /// List Widget View
              ListWidgetView(),
              SizedBox(height: 30),

              /// Bottom Widget View
              BottomWidgetView(),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  /// List Widget View
  Widget ListWidgetView() {
    return ListView.builder(
      padding: EdgeInsets.only(left: 25, right: 25, top: 20),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: Lists.listViewList.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: 7),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: greyE7E, width: 1),
            color: white,
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Lists.listViewList[index]
                      ["icon"], // use icon instead of image
                  color: Colors.green,
                  size: 30,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextWidget.InterSemiBold(
                        color: black171,
                        fontSize: 14,
                        text: Lists.listViewList[index]["text1"],
                      ),
                      SizedBox(height: 3),
                      CommonTextWidget.InterRegular(
                        color: grey6A7,
                        fontSize: 10,
                        text: Lists.listViewList[index]["text2"],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Bottom Widget View
  Widget BottomWidgetView() {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget.InterBold(
            color: black171,
            fontSize: 15,
            text: "invite_friends".tr,
          ),
          SizedBox(height: 10),
          CommonTextWidget.InterRegular(
            color: black171,
            fontSize: 13,
            text: "invite_reward",
          ),
          SizedBox(height: 25),
          MaterialButton(
            onPressed: () {},
            height: 30,
            minWidth: 65,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: green21E.withOpacity(0.29),
            child: CommonTextWidget.InterSemiBold(
              fontSize: 16,
              text: "invite".tr,
              color: white,
            ),
          )
        ],
      ),
    );
  }

  /// Bottom Image Widget View
  Widget BottomImageWidgetView() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Image.asset(Images.homeBottomImage),
      // Container(
      //   height: 400,
      //   width: Get.width,
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage(Images.homeBottomImage),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      // ),
    );
  }
}

class OutlineTile extends StatelessWidget {
  final String iconAsset, title, subtitle;
  const OutlineTile(
      {super.key,
      required this.iconAsset,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    const Color greenText = Color.fromARGB(255, 248, 251, 249);
    return Container(
      // ❌ REMOVE margin here

      padding: const EdgeInsets.all(16), // ✅ keep padding
      decoration: BoxDecoration(
        color: greenText,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.green, width: 0.6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(iconAsset, width: 28, height: 28, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
                Text(subtitle,
                    style: TextStyle(
                        fontSize: 13, color: Colors.black.withOpacity(.7))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BigFeatureTile extends StatelessWidget {
  final String iconAsset; // e.g. assets/images/milk.png
  final String title; // e.g. Milk Collection
  final String subtitle; // e.g. Sell, Purchase
  final VoidCallback? onTap;

  const BigFeatureTile({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color green = Color(0xFF177A49);
    const Color greenText = Color(0xFF0D5C37);
    const Color chipBg = Color(0xFFF7FBF8); // very light green/white

    return Material(
      color: chipBg,
      borderRadius: BorderRadius.circular(22),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border:
                Border.all(color: green.withOpacity(.2), width: 1), // ✅ border
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon chip (matches the green-outlined look)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF6EF), // pale green
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Image.asset(
                  iconAsset,
                  width: 34,
                  height: 34,
                  // if you need tinting for a single-color PNG, uncomment:
                  // color: green,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: greenText,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        height: 1.0,
                        letterSpacing: .2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: greenText.withOpacity(.70),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
