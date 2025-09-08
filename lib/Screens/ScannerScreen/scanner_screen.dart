import 'dart:developer';
import 'dart:io';
import 'package:digitalwalletpaytmcloneapp/Constants/colors.dart';
import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/EnterAndSearchMobileNumberScreen/enter_mobile_number_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ScannerScreen/payment_code_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Utils/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class ScannerScreen extends StatefulWidget {
  ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  MobileScannerController cameraController = MobileScannerController();


  Barcode? result;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: white,
              size: 24,
            ),
          ),
        ),
        title: CommonTextWidget.InterSemiBold(
          text: "Scan Any QR Code",
          fontSize: 18,
          color: white,
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 250,
                      width: Get.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child:MobileScanner(
                    
                        scanWindow: Rect.fromCenter(
                          center: Offset(
                            MediaQuery.of(context).size.width / 2,
                            MediaQuery.of(context).size.height / 3,
                          ),
                          width: 250, // Width of the scan window
                          height: 250, // Height of the scan window
                        ),
                        controller: cameraController,
                       
                        onDetect: (barcode) {
                          if (barcode.raw != null) {
                            final String code = barcode.toString();
                            log('QR Code Found: $code');
                          
                          } else {
                            debugPrint('Failed to scan QR Code.');
                          }
                        },
                      ),
                        
                        //  QRView(
                        //   key: qrKey,
                        //   overlay: QrScannerOverlayShape(
                        //     cutOutSize: MediaQuery.of(context).size.width * 0.5,
                        //     borderRadius: 20,
                        //     borderWidth: 8,
                        //     borderColor: white,
                        //     overlayColor: black,
                        //   ),
                        //   onQRViewCreated: (QRViewController controller) {
                        //     setState(() {
                        //       qrViewController = controller;
                        //     });
                        //   },
                        // ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 85),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => PaymentCodeScreen());
                      },
                      child: Container(
                        height: 40,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: white.withOpacity(0.06),
                          ),
                          color: white.withOpacity(0.25),
                          boxShadow: [
                            BoxShadow(
                              color: black111.withOpacity(0.02),
                              spreadRadius: 0,
                              offset: Offset(0, 4),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            children: [
                            SvgPicture.asset(Images.scan,color: Colors.green,),
                              SizedBox(width: 8),
                              CommonTextWidget.InterMedium(
                                text: "Show Payment Code",
                                fontSize: 12,
                                color: white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                SvgPicture.asset(Images.light),
                  SizedBox(width: 12),
                SvgPicture.asset(Images.gallery),
                ],
              ),
              SizedBox(height: 80),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 6,
                width: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: white,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => EnterMobileNumberScreen());
                    },
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(88),
                        color: whiteF9F,
                        border: Border.all(
                          color: greyA6A,
                          width: 0.5,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonTextWidget.InterRegular(
                              text: "Enter Mobile Number or Name",
                              fontSize: 14,
                              color: greyA6A,
                            ),
                          SvgPicture.asset(Images.book,color: Colors.green,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
