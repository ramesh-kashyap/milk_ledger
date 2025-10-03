import 'package:digitalwalletpaytmcloneapp/Constants/images.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/AllServicesScreen/all_services_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/CashBackAndOfferScreen/cashback_and_offer_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/DigiLockerScreen/digi_locker_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HelpScreen/help_screen2.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/CreditCardScreen/credit_card_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/DigiwalletTicketScreens/digiwallet_ticket_tab_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/DthRechargeScreen/dth_recharge_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/FastagScreen/select_your_fastag_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MetroScreen/select_your_metro_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/PayElectricityBillScreens/pay_electricitybill_tab_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/balance_and_history_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/car_insurance_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/digiwallet_postpaid_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/digiwallet_profileupdate_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/enter_upi_id_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MobileRechargeScreens/mobile_recharge_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/MovieScreens/movie_ticket_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/to_mobile_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/HomeScreen/to_self_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/OrederAndBookingScreens/recent_order_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PaymentSettingScreen/DigiWalletScreen/digi_wallet_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PaymentSettingScreen/DigiWalletScreen/payment_limits_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PaymentSettingScreen/DigiWalletScreen/third_party_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PaymentSettingScreen/SaveCardsScreen/save_cards_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PaymentSettingScreen/UpiAndLinkAccountScreens/upi_and_link_account_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PaymentSettingScreen/payment_setting_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/PersonalLoanScreen/personal_loan_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ProfileScreen/profile_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/ReferAndEarnScreen/refer_and_earn_screen.dart';
import 'package:digitalwalletpaytmcloneapp/Screens/TermsConditionsAndPrivacyPolicyScreens/Policies_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Lists {
  static List<Map> myDigiWalletList = [
    {
      "image": Images.balanceAndHistory,
      "text": "Balance & \nHistory",
      "onTap": () {
        Get.to(() => BalanceAndHistoryScreen());
      }
    },
    {
      "image": Images.wallet,
      "text": "EcoPay Wallet",
      "onTap": () {
        Get.to(() => DigiWalletProfileUpdateScreen());
      }
    },
    {
      "image": Images.carInsurance,
      "text": "Car \nInsurance",
      "onTap": () {
        Get.to(() => CarInsuranceScreen());
      }
    },
    {
      "image": Images.personalLoan,
      "text": "Personal\nLoan",
      "onTap": () {
        Get.to(() => PersonalLoanScreen());
      }
    },
    {
      "image": Images.digitalWalletPostpaid,
      "text": "EcoPay Wallet\nPostpaid",
      "onTap": () {
        Get.to(() => DigiwalletPostPaidScreen());
      }
    },
    {
      "image": Images.creditcard,
      "text": "Credit\nCards",
      "onTap": () {
        Get.to(() => CreditCardScreen());
      }
    },
    {
      "image": Images.movieTickets,
      "text": "Movie\nTickets",
      "onTap": () {
        Get.to(() => MovieTicketScreen());
      }
    },
    {
      "image": Images.allServices,
      "text": "All Services",
      "onTap": () {
        Get.to(() => AllServicesScreen());
      }
    },
  ];

  static List banner1List = [
    Images.banner1Image1,
    Images.banner1Image1,
    Images.banner1Image1,
  ];

  static List<Map> rechargeAndBillPaymentsList = [
    {
      "image": Images.mobileRecharge,
      "text": "Mobile\nRecharge",
      "onTap": () {
        Get.to(() => MobileRechargeScreen());
      }
    },
    {
      "image": Images.rentViaCreditCard,
      "text": "Rent via\nCredit Card",
    },
    {
      "image": Images.dthRecharge,
      "text": "DTH\nRecharge",
      "onTap": () {
        Get.to(() => DthRechargeScreen());
      },
    },
    {
      "image": Images.electricityBill,
      "text": "Electricity\nBill",
      "onTap": () {
        Get.to(() => PayElectricityBillTabScreen());
      },
    },
    {
      "image": Images.creditcard,
      "text": "Credit Card\nPayment",
      "onTap": () {
        Get.to(() => CreditCardScreen());
      },
    },
    {
      "image": Images.mobilePostPaid,
      "text": "Mobile\nPostpaid",
      "onTap": () {
        Get.to(() => MobileRechargeScreen());
      },
    },
    {
      "image": Images.bookGasCylinder,
      "text": "Book Gas\nCylinder",
      "onTap": () {
        // Get.to(() => CreditCardScreen());
      },
    },
    {
      "image": Images.broadBandLandline,
      "text": "Broadband\nLandline",
      "onTap": () {
        // Get.to(() => CreditCardScreen());
      },
    },
  ];

  static List<Map> loanAndCreditCardList = [
    {
      "image": Images.digitalWalletPostpaid,
      "text": "Paytm\nPostpaid",
      "onTap": () {
        Get.to(() => DigiwalletPostPaidScreen());
      },
    },
    {
      "image": Images.personalLoan,
      "text": "Personal\nLoan",
      "onTap": () {
        Get.to(() => PersonalLoanScreen());
      },
    },
    {
      "image": Images.freeCreditScore,
      "text": "Free Credit\nScore",
    },
    {
      "image": Images.creditcard,
      "text": "Credit\nCards",
    },
  ];

  static List<Map> ticketBookingList = [
    {
      "image": Images.flightTickets,
      "text": "Flight\nTickets",
      "onTap": () {
        Get.to(() => DigiwalletTicketTabScreen());
      },
    },
    {
      "image": Images.busTickets,
      "text": "Bus Tickets",
    },
    {
      "image": Images.trainTickets,
      "text": "Train\nTickets",
    },
    {
      "image": Images.movieTickets2,
      "text": "Movie\nTickets",
    },
    {
      "image": Images.creditCard2,
      "text": "FASTag\nRecharge",
    },
    {
      "image": Images.eventTickets,
      "text": "Event\nTickets",
    },
    {
      "image": Images.metroTickets,
      "text": "Metro Tickets",
      "onTap": () {
        Get.to(() => SelectYourMetroScreen());
      },
    },
    {
      "image": Images.buyFastag,
      "text": "Buy FASTag",
      "onTap": () {
        Get.to(() => SelectYourFastagScreen());
      },
    },
  ];

  static List<Map> investAndTradStockList = [
    {
      "image": Images.openDematAccount,
      "text": "Open Demat\nAccount",
    },
    {
      "image": Images.saveMoney,
      "text": "Invest with\n\$ 500",
    },
    {
      "image": Images.paytmStock,
      "text": "Paytm\nStocks",
    },
    {
      "image": Images.mutualFunds,
      "text": "Mutual\nFunds",
    },
  ];

  static List<Map> insuranceList = [
    {
      "image": Images.bikeInsurance,
      "text": "Youtube ",
    },
    {
      "image": Images.carInsurance,
      "text": "Facebook",
    },
    {
      "image": Images.healthInsurance1,
      "text": "Instagram",
    },
    {
      "image": Images.accidentInsurance,
      "text": "Accidental\nInsurance",
    },
  ];

  static List<Map> firstGamesByDigiWalletList = [
    {
      "image": Images.rummy,
      "text": "Rummy",
    },
    {
      "image": Images.poker,
      "text": "Poker",
    },
    {
      "image": Images.ludo,
      "text": "Ludo",
    },
    {
      "image": Images.cricketAndCash,
      "text": "Cricket &\nCash",
    },
  ];

  static List<Map> discoverWithDigiWallet = [
    {
      "image": Images.rummyCulture,
      "text": "Rummy\nCulture",
    },
    {
      "image": Images.decathlon,
      "text": "Decathlon",
    },
    {
      "image": Images.mcDelivery,
      "text": "McDelivery",
    },
    {
      "image": Images.bewakoof,
      "text": "Bewakoof",
    },
    {
      "image": Images.dominos,
      "text": "Domino’s",
    },
    {
      "image": Images.calculator,
      "text": "EMI\nCalculator",
    },
    {
      "image": Images.goQii,
      "text": "GoQii",
    },
    {
      "image": Images.mensome,
      "text": "Mensome",
    },
  ];

  static List<Map> digiWalletHealthList = [
    {
      "image": Images.orderMedicines,
      "text": "Order\nMedicines",
    },
    {
      "image": Images.healthPass,
      "text": "Health Pass",
    },
    {
      "image": Images.mediclaimCalculator,
      "text": "Mediclaim\nCalculator",
    },
    {
      "image": Images.healthInsurance,
      "text": "Health\nInsurance",
    },
  ];

  static List<Map> listViewList = [
  {
    "icon": Icons.help_outline,
    "text1": "faq",        // store key only
    "text2": "faq_desc",
  },
  {
    "icon": Icons.play_circle_fill,
    "text1": "show_videos",
    "text2": "show_videos_desc",
  },
  {
    "icon": Icons.phone_in_talk,
    "text1": "contact_us",
    "text2": "contact_us_desc",
  },
  {
    "icon": Icons.subscriptions,
    "text1": "subscription",
    "text2": "subscription_desc",
  },
  {
    "icon": Icons.print,
    "text1": "purchase_printer",
    "text2": "purchase_printer_desc",
  },
];



  static List<Map> enterContactList = [
    {
      "image": Images.jason,
      "text1": "Jason Adam",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.harry,
      "text1": "Harry Leo",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.mandy,
      "text1": "Mandy Lin",
      "text2":
          "Invite Mandy Lin to experience DigiWallet Money Transfer and earn ₹100",
    },
    {
      "image": Images.maria,
      "text1": "Maria Sam",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.lucas,
      "text1": "Lucas ",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.maya,
      "text1": "Maya",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.mandy1,
      "text1": "Mandy Lin",
      "text2":
          "Invite Mandy Lin to experience DigiWallet Money Transfer and earn ₹100",
    },
    {
      "image": Images.peterson,
      "text1": "Peterson",
      "text2": "+91 12345 67890",
    },
  ];

  static List<Map> searchContactList1 = [
    {
      "image": Images.jason,
      "text1": "Jason Adam",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.harry,
      "text1": "Harry Leo",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.mandy,
      "text1": "Mandy Lin",
      "text2":
          "Invite Mandy Lin to experience DigiWallet Money Transfer and earn ₹100",
    },
  ];

  static List<Map> searchContactList2 = [
    {
      "image": Images.maria,
      "text1": "Maria Sam",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.lucas,
      "text1": "Lucas ",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.maya,
      "text1": "Maya",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.mandy1,
      "text1": "Mandy Lin",
      "text2":
          "Invite Mandy Lin to experience DigiWallet Money Transfer and earn ₹100",
    },
    {
      "image": Images.peterson,
      "text1": "Peterson",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.jason,
      "text1": "Jason Adam",
      "text2": "+91 12345 67890",
    },
  ];

  static List<Map> usePayOptionList = [
    {
      "image": Images.bobImge,
      "text1": "Bank of Baroda XX1234",
      "text2": "Check Balance",
    },
    {
      "image": Images.splashImage,
      "text1": "Eco Pay Wallet",
      "text2": "Available Balance ₹100",
    },
  ];

  static List<Map> userQrCodeList = [
    {
      "icon": Icons.bar_chart, // Report
      "text1": "report".tr,
      "text2": "report_desc".tr,
      "onTap": () {
        Get.to(() => ProfileScreen());
      },
    },
    {
      "icon": Icons.delete, // Delete Client
      "text1": "delete_client".tr,
      "text2": "delete_client_desc".tr,
      "onTap": () {
        Get.to(() => ProfileScreen());
      },
    },
    {
      "icon": Icons.account_balance, // All Account
      "text1": "all_account".tr,
      "text2": "all_account_desc".tr,
      "onTap": () {
        Get.to(() => ProfileScreen());
      },
    },
    {
      "icon": Icons.privacy_tip, // Privacy Policy
      "text1": "privacy_policy".tr,
      "text2": "privacy_policy_desc".tr,
      "onTap": () {
        Get.to(() => ProfileScreen());
      },
    },
    {
      "icon": Icons.phone, // Contact Us
      "text1": "contact_us".tr,
      "text2": "contact_us_desc".tr,
      "onTap": () {
        Get.to(() => ProfileScreen());
      },
    },
    {
      "icon": Icons.info, // About Us
      "text1": "about_us".tr,
      "text2": "about_us_desc".tr,
      "onTap": () {
        Get.to(() => ProfileScreen());
      },
    },
    {
      "icon": Icons.person_remove, // Delete Account
      "text1": "delete_account".tr,
      "text2": "delete_account_desc".tr,
      "onTap": () {
        Get.to(() => ProfileScreen());
      },
    },
    {
      "icon": Icons.system_update, // Check Update
      "text1": "check_update".tr,
      "text2": "check_update_desc".tr,
      "onTap": () {
        Get.to(() => ProfileScreen());
      },
    },
  ];


  static List<Map> helpList = [
    {
      "image": Images.helpRupieeImage,
      "text1": "Received from John Doe",
      "text2": "₹120",
      "text3": "11 se’p22, 08:07 PM",
    },
    {
      "image": Images.helpDigiWalletImage,
      "text1": "Failed Payment at Swiggy",
      "text2": "₹175",
      "text3": "2 sep’22, 08:07 PM",
    },
    {
      "image": Images.helpDigiWalletImage,
      "text1": "Paid for Order at Arnee Automobiles",
      "text2": "₹200",
      "text3": "11 sep’22, 08:07 PM",
    },
  ];

  static List<Map> helpViewAllList = [
    {
      "image": Images.helpRupieeImage,
      "text1": "Received from John Doe",
      "text2": "₹120",
      "text3": "11 se’p22, 08:07 PM",
    },
    {
      "image": Images.helpDigiWalletImage,
      "text1": "Failed Payment at Swiggy",
      "text2": "₹175",
      "text3": "2 sep’22, 08:07 PM",
    },
    {
      "image": Images.helpDigiWalletImage,
      "text1": "Paid for Order at Arnee Automobiles",
      "text2": "₹200",
      "text3": "11 sep’22, 08:07 PM",
    },
    {
      "image": Images.helpRupieeImage,
      "text1": "Failed Payment to Cameron Williamson",
      "text2": "₹1500",
      "text3": "11 se’p22, 08:07 PM",
    },
    {
      "image": Images.helpDigiWalletImage,
      "text1": "Paid for Order at Arnee Automobiles",
      "text2": "₹200",
      "text3": "11 sep’22, 08:07 PM",
    },
    {
      "image": Images.helpRupieeImage,
      "text1": "Sent to Brooklyn Simmons",
      "text2": "₹1500",
      "text3": "11 sep’22, 08:07 PM",
    },
    {
      "image": Images.helpRupieeImage,
      "text1": "Received from John Doe",
      "text2": "₹120",
      "text3": "11 sep’22, 08:07 PM",
    },
    {
      "image": Images.helpDigiWalletImage,
      "text1": "Paid for Order at Arnee Automobiles",
      "text2": "₹200",
      "text3": "11 sep’22, 08:07 PM",
    },
    {
      "image": Images.helpDigiWalletImage,
      "text1": "Failed Payment to Cameron Williamson",
      "text2": "₹1500",
      "text3": "11 sep’22, 08:07 PM",
    },
  ];

  static List<Map> helpList2 = [
    {
      "image": Images.rechargeBill,
      "text1": "Recharges & Bill Payments",
      "text2": "Mobile, Electricity, Gas Dth, Cylinder Booking Etc",
    },
    {
      "image": Images.digiWallet,
      "text1": "DigiWallet",
      "text2": "Your Wallet transactions  & balance",
    },
    {
      "image": Images.upiPaymentAndMoneyTransfer,
      "text1": "UPI Payments & Money Transfer",
      "text2": "UPI Settings & Transactions",
    },
    {
      "image": Images.digiWalletKyc,
      "text1": "DigiWallet KYC",
      "text2": "Placing KYC request, wallet upgrade etc",
    },
  ];

  static List<Map> helpList3 = [
    {
      "image": Images.security,
      "text1": "Account Safety Tips",
      "text2": "Guidelines to safeguard your account and money",
      "text3": "Know more",
    },
    {
      "image": Images.mobileTransfer,
      "text1": "Sent money through DigiWallet but receiver did not get it?",
      "text2": "Guidelines to safeguard your account and money",
      "text3": "Here is what you can do",
    },
  ];

  static List<Map> popularHelpList = [
    {
      "image": Images.security,
      "text1": "Account Safety Tips",
      "text2": "Guidelines to safeguard your account and money",
      "text3": "Know more",
    },
    {
      "image": Images.mobileTransfer,
      "text1": "Sent money through DigiWallet but receiver did not get it?",
      "text2": "Guidelines to safeguard your account and money",
      "text3": "Here is what you can do",
    },
    {
      "image": Images.transaction,
      "text1": "Money got deducted from bank account but not added to wallet?",
      "text2": "No need to worry! your money is safe under all circumstances",
      "text3": "Kow more",
    },
    {
      "image": Images.mobileTransfer,
      "text1": "Transaction failed but money got deducted?",
      "text2":
          "No need to worry! Read here to know why this happened and when will you get the refund",
      "text3": "Learn about the refund process",
    },
    {
      "image": Images.mobileTransfer,
      "text1": "Money Deducted while doing recharge, but Payment is pending",
      "text2":
          "Recharge order is showing message ‘Payments of Rs XX is pending’?",
      "text3": "Here is what you can do",
    },
  ];

  static List<Map> chooseServicesList = [
    {
      "image": Images.rechargeBill,
      "text1": "Recharges & Bill Payments",
      "text2": "Mobile, Electricity, Gas Dth, Cylinder Booking Etc",
    },
    {
      "image": Images.digiWallet,
      "text1": "DigiWallet",
      "text2": "Your Wallet transactions  & balance",
    },
    {
      "image": Images.upiPaymentAndMoneyTransfer,
      "text1": "UPI Payments & Money Transfer",
      "text2": "UPI Settings & Transactions",
    },
    {
      "image": Images.digiWalletKyc,
      "text1": "DigiWallet KYC",
      "text2": "Placing KYC request, wallet upgrade etc",
    },
    {
      "image": Images.flightTickets,
      "text1": "Travel",
      "text2": "Trains, Flights & Bus bookings",
    },
    {
      "image": Images.movieTickets2,
      "text1": "Movies & Events",
      "text2": "Movies, Events & Amusement Parks",
    },
    {
      "image": Images.digitalWalletPostpaid,
      "text1": "DigiWallet Postpaid",
      "text2": "Your Wallet transactions  & balance",
    },
    {
      "image": Images.creditcard,
      "text1": "Credit Card",
      "text2": "Credit Card related queries",
    },
    {
      "image": Images.freeCreditScore,
      "text1": "Credit Score  & Loan Offers",
      "text2": "Placing KYC request, wallet upgrade etc",
    },
    {
      "image": Images.giftCard,
      "text1": "Deals & Gift Vouchers",
      "text2": "Deals, Gift Vouchers, etc",
    },
    {
      "image": Images.savingAccount,
      "text1": "Savings Account, Debit Card, Fix...",
      "text2": "Placing KYC request, wallet upgrade etc",
    },
    {
      "image": Images.security,
      "text1": "Report fraud transactions",
      "text2": "Unauthorized transactions, misuse of bank details etc",
    },
  ];

  static List<Map> paymentSettingList = [
    {
      "image": Images.upiAndLinkBankAccount,
      "text1": "UPI & Linked Bank Accounts",
      "text2":
          "Linked  Bank Accounts, Request Money Payment Requests, UPI Automatic Payments, Manage Beneficiaries",
      "onTap": () {
        Get.to(() => UpiAndLinkAccountScreen());
      },
    },
    {
      "image": Images.digiWallet,
      "text1": "DigiWallet",
      "text2": "Payment Limits, Third-party Apps, Refund Settings",
      "onTap": () {
        Get.to(() => DigiWalletScreen());
      },
    },
    {
      "image": Images.creditcard,
      "text1": "Saved Cards",
      "text2": "Manage your saved cards or add new cards",
      "onTap": () {
        Get.bottomSheet(
          SaveCardsScreen(),
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
        );
      },
    },
    {
      "image": Images.automaticPaymentAndSubscription,
      "text1": "Automatic Payments & Subscriptions",
      "text2": "Add or modify your automatic payments & subscriptions",
      "onTap": () {},
    },
    {
      "image": Images.digiWalletAssist,
      "text1": "DigiWallet Assist",
      "text2": "Enable automatic OTP submission at the time of making payments",
      "onTap": () {},
    },
    {
      "image": Images.digitalWalletPostpaid,
      "text1": "DigiWallet Postpaid",
      "text2": "Manage your DigiWallet Postpaid account",
      "onTap": () {},
    },
    {
      "image": Images.paymentReminder,
      "text1": "Payment Reminder",
      "text2": "Reminders for frequent Payment",
      "onTap": () {},
    },
  ];

  static List<Map> upiAndLinkAccountList = [
    {
      "image": Images.paymentRequest,
      "text1": "Payment Requests",
      "text2": "View all requests received by you",
      "onTap": () {},
    },
    {
      "image": Images.fingerprint,
      "text1": "Fingerprint ID",
      "text2": "Enable Fingerprint to verify payments from DigiWallet Bank",
      "onTap": () {},
    },
    {
      "image": Images.renewableEnergy,
      "text1": "UPI Automatic Payments",
      "text2": "Manage all your UPI Automatic Payments",
      "onTap": () {},
    },
    {
      "image": Images.ipo,
      "text1": "IPO Bid Requests",
      "text2": "Approve your IPO Bid Requests",
      "onTap": () {},
    },
    {
      "image": Images.manageBeneficiaries,
      "text1": "Manage Beneficiaries",
      "text2": "View, add and remove your Beneficiaries",
      "onTap": () {},
    },
    {
      "image": Images.femaleServicesSupportIcon,
      "text1": "Help & Support",
      "text2": "24x7 customer support, your tickets, FAQ",
      "onTap": () {},
    },
    {
      "image": Images.manageUpi,
      "text1": "Manage UPI Number",
      "text2": "Receive money from any UPI App",
      "onTap": () {},
    },
  ];

  static List<Map> popularBanksList = [
    {
      "image": Images.axixBank,
      "text": "Axis Bank",
    },
    {
      "image": Images.hdfcBank,
      "text": "HDFC Bank",
    },
    {
      "image": Images.icicBank,
      "text": "ICICI Bank",
    },
    {
      "image": Images.statBank,
      "text": "State Bank of i..",
    },
    {
      "image": Images.bankOfIndia,
      "text": "Bank of India",
    },
    {
      "image": Images.bankOfBaroda,
      "text": "Bank of Baroda",
    },
  ];

  static List<Map> allOtherBanksList = [
    {
      "image": Images.allOtherBank,
      "text": "A P Mahesh Bank",
    },
    {
      "image": Images.allOtherBank,
      "text": "AU Small Finance Bank",
    },
    {
      "image": Images.abhyuday,
      "text": "Abhyuday Cooperative Bank Ltd",
    },
    {
      "image": Images.allOtherBank,
      "text": "Adarsh Co-operative Bank Limited",
    },
    {
      "image": Images.allOtherBank,
      "text": "Ahmednagar Merchants Cooperative \nBank Ltd",
    },
    {
      "image": Images.airtelImage,
      "text": "Airtel Payments Bank",
    },
    {
      "image": Images.allOtherBank,
      "text": "Ajantha Urban Co-op Bank Ltd",
    },
  ];
  static List<Map> digiWalletList = [
    {
      "image": Images.paymentLimits,
      "text1": "Payment Limits",
      "text2": "Setup & manage limits on your daily and monthly payments",
      "onTap": () {
        Get.to(() => PaymentLimitsScreen());
      },
    },
    {
      "image": Images.thirdPartyApp,
      "text1": "Third Party Apps Linked With Wallet",
      "text2": "Manage apps where your DigiWallet is Linked for payments",
      "onTap": () {
        Get.to(() => ThirdPartyScreen());
      },
    },
  ];

  static List<Map> paymentLimitsList = [
    {
      "text": "Merchants",
    },
    {
      "text": "DigiWallet User",
    },
    {
      "text": "Send Money to Bank",
    },
  ];

  static List<Map> recentOrderList = [
    {
      "image": Images.viImage,
      "text1": "Recharge of Vi\n12345 67890",
      "text2": "₹ 999, Your order is successful",
    },
    {
      "image": Images.digiWalletLogo,
      "text1": "Add money to wallet ₹2000",
      "text2": "Successful",
    },
    {
      "image": Images.jioImage,
      "text1": "Recharge For Jio\n12345 67890",
      "text2": "₹ 599, Your order is successful",
    },
    {
      "image": Images.torrentPowerImage,
      "text1": "Bill Payment for Torrent Power\nLimited 123456789",
      "text2": "Successful",
    },
    {
      "image": Images.viImage,
      "text1": "Recharge of Vi\n12345 67890",
      "text2": "₹ 999, Your order is successful",
    },
    {
      "image": Images.digiWalletLogo,
      "text1": "Add money to wallet ₹2000",
      "text2": "Successful",
    },
  ];

  static List sortOrderList = [
    "Open",
    "Completed",
    "Cancelled",
  ];

  static List showOrderList = [
    "Last 30 Days",
    "Last 6 Months",
    "Current Year",
    "2021",
    "2020",
  ];

  static List<Map> centralGovernmentList = [
    {
      "image": Images.agricultural,
      "text": "Agricultural Scientists..",
    },
    {
      "image": Images.centralBaroda,
      "text": "Central Board of Secondar..",
    },
    {
      "image": Images.centralPension,
      "text": "Central Pension...",
    },
    {
      "image": Images.commonServiceCentral,
      "text": "Common Service Cent...",
    },
  ];

  static List<Map> statGovernmentList = [
    {
      "image": Images.accountantsGeneral,
      "text": "Accountants General",
    },
    {
      "image": Images.additionalSkill,
      "text": "Additional Skill...",
    },
    {
      "image": Images.andamanLaw,
      "text": "Andaman Law College",
    },
    {
      "image": Images.assamStat,
      "text": "Assam State Board of...",
    },
  ];

  static List<Map> educationGovernmentList = [
    {
      "image": Images.additionalSkill,
      "text": "Additional Skill...",
    },
    {
      "image": Images.adichunchanagiri,
      "text": "Adichunchanagiri University",
    },
    {
      "image": Images.ahemdabad,
      "text": "Ahmedabad University",
    },
    {
      "image": Images.aiimsRishikesh,
      "text": "AIIMS Rishikesh",
    },
  ];

  static List<Map> bankingAndInsuranceGovernmentList = [
    {
      "image": Images.acko,
      "text": "Acko General Insurance...",
    },
    {
      "image": Images.aegonLife,
      "text": "Aditya Birla Housing...",
    },
    {
      "image": Images.aegon,
      "text": "Aegon Life Insurance...",
    },
    {
      "image": Images.bajaj,
      "text": "Bajaj Allianz General",
    },
  ];

  static List<Map> digiLockerViewAllList = [
    {
      "image": Images.agricultural,
      "text": "Agricultural Scientists..",
    },
    {
      "image": Images.centralBaroda,
      "text": "Central Board of Secondar..",
    },
    {
      "image": Images.centralPension,
      "text": "Central Pension...",
    },
    {
      "image": Images.centralPension,
      "text": "Central Pension...",
    },
    {
      "image": Images.agricultural,
      "text": "Agricultural Scientists..",
    },
    {
      "image": Images.centralBaroda,
      "text": "Central Board of Secondar..",
    },
    {
      "image": Images.centralBaroda,
      "text": "Central Board of Secondar..",
    },
    {
      "image": Images.agricultural,
      "text": "Agricultural Scientists..",
    },
    {
      "image": Images.centralBaroda,
      "text": "Central Board of Secondar..",
    },
    {
      "image": Images.agricultural,
      "text": "Agricultural Scientists..",
    },
    {
      "image": Images.centralPension,
      "text": "Central Pension...",
    },
    {
      "image": Images.centralBaroda,
      "text": "Central Board of Secondar..",
    },
  ];

  static List<Map> digiLockerSearchList = [
    {
      "text1": "PAN Card",
      "text2": "Income Tax Department",
    },
    {
      "text1": "Driving License",
      "text2": "Ministry of Road Transport and Highways",
    },
    {
      "text1": "Class 10th Marksheet",
      "text2": "Central Board of Secondary Education",
    },
    {
      "text1": "Class 12th Marksheet",
      "text2": "Central Board of Secondary Education",
    },
    {
      "text1": "RC",
      "text2": "Ministry of Road Transport and Highways",
    },
  ];

  static List<Map> convertCashBackList = [
    {
      "image": Images.winFree,
      "text": "Win Free Sunglasses",
    },
    {
      "image": Images.winNoise,
      "text": "Win Noise Smartwatch",
    },
    {
      "image": Images.freeSkinCare,
      "text": "Free Skin Care kit",
    },
    {
      "image": Images.giftCard1,
      "text": "Gift Card worth ₹5k",
    },
    {
      "image": Images.giftCard2,
      "text": "Gift Card worth ₹5k",
    },
    {
      "image": Images.assured,
      "text": "Assured Free gift",
    },
    {
      "image": Images.dailyObject,
      "text": "Daily Objects",
    },
    {
      "image": Images.sugarMatte,
      "text": "Sugar Matte Lipstick",
    },
  ];

  static List<Map> exclusiveOffersList = [
    {
      "image": Images.scanAndPay1,
      "text": "Scan & Pay Offers",
    },
    {
      "image": Images.onlineOffer,
      "text": "Online Offers",
    },
    {
      "image": Images.upiAndMt,
      "text": "UPI & MT Offers",
    },
    {
      "image": Images.mobileRecharge,
      "text": "Bill Payment Offers",
    },
    {
      "image": Images.digitalWalletPostpaid,
      "text": "Postpaid Offers",
    },
    {
      "image": Images.walletOffer,
      "text": "Wallet Offers",
    },
  ];

  static List<Map> todayList = [
    {
      "image": Images.fuelStation,
      "text1": "For fuel payment at local petrol pump on Apr 27,..",
      "text2": "₹120",
      "text3": "08:07 PM",
    },
    {
      "image": Images.upiAndMt,
      "text1": "For Transferring Money on Feb 13, 2022",
      "text2": "₹80",
      "text3": "08:07 PM",
    },
  ];

  static List<Map> marchList = [
    {
      "image": Images.fuelStation,
      "text1": "For fuel payment at local petrol pump on Apr 27,..",
      "text2": "₹120",
      "text3": "12 March",
    },
    {
      "image": Images.upiAndMt,
      "text1": "For Transferring Money on Feb 13, 2022",
      "text2": "₹80",
      "text3": "10 March",
    },
    {
      "image": Images.fuelStation,
      "text1": "For fuel payment at local petrol pump on Apr 27,..",
      "text2": "₹120",
      "text3": "9 March",
    },
    {
      "image": Images.upiAndMt,
      "text1": "For Transferring Money on Feb 13, 2022",
      "text2": "₹80",
      "text3": "6 March",
    },
    {
      "image": Images.fuelStation,
      "text1": "For fuel payment at local petrol pump on Apr 27,..",
      "text2": "₹120",
      "text3": "2 March",
    },
  ];

  static List<Map> allServicesList = [
    {
      "image": Images.wallet,
      "text": "Digi Wallet",
    },
    {
      "image": Images.carInsurance,
      "text": "Car\nInsurance",
    },
    {
      "image": Images.personalLoan,
      "text": "Personal\nLoan",
    },
    {
      "image": Images.creditcard,
      "text": "Credit\nCards",
    },
    {
      "image": Images.movieTickets,
      "text": "Movie\nTickets",
    },
    {
      "image": Images.allServices,
      "text": "All Services",
    },
    {
      "image": Images.bikeInsurance,
      "text": "Bike\nInsurance",
    },
    {
      "image": Images.carInsurance,
      "text": "Car\nInsurance",
    },
    {
      "image": Images.healthInsurance1,
      "text": "All Services",
    },
    {
      "image": Images.rummy,
      "text": "Rummy",
    },
  ];

  static List<Map> referAndEarnList = [
    {
      "image": Images.tongkunLee,
      "text": "Tongkun Lee",
    },
    {
      "image": Images.rehmemKhihal,
      "text": "Rehmem Khihal",
    },
    {
      "image": Images.fazurNalim,
      "text": "Fazur Nalim",
    },
    {
      "image": Images.boa,
      "text": "Boa Palegleam",
    },
    {
      "image": Images.gurkir,
      "text": "Gurkir Glorymore",
    },
    {
      "image": Images.tongkunLee,
      "text": "Tongkun Lee",
    },
  ];

  static List<Map> toBankAccountList = [
    {
      "image": Images.bank,
      "text1": "Enter Bank A/c\ndetails",
      "text2": "Choose Bank or enter IFSC details",
      "onTap": () {
        // Get.to(() => ToMobileScreen());
      },
    },
    {
      "image": Images.upiImage,
      "text1": "Enter UPI ID",
      "text2": "Pay to Bank A/c using UPI ID",
      "onTap": () {
        Get.to(() => EnterUpiIdScreen());
      },
    },
    {
      "image": Images.toMobile,
      "text1": "Enter Mobile\nNumber",
      "text2": "Direct transfer to linked bank a/c",
      "onTap": () {
        Get.to(() => ToMobileScreen());
      },
    },
    {
      "image": Images.toSelf,
      "text1": "To Self",
      "text2": "Send Money to your own a/c",
      "onTap": () {
        Get.to(() => ToSelfScreen());
      },
    },
  ];

  static List<Map> toBankAccountRecentList = [
    {
      "image": Images.jason,
      "text1": "Jason Adam",
      "text2": "UPI ID: 1234567890@DigiWallet",
      "text3": "Paid ₹1,200 on Yesterday",
    },
    {
      "image": Images.harry,
      "text1": "Harry Leo",
      "text2": "Bank Of Baroda A/c XX1234",
      "text3": "Paid ₹1,200 on Yesterday",
    },
    {
      "image": Images.maria,
      "text1": "Maria Sam",
      "text2": "UPI ID: 1234567890@DigiWallet",
      "text3": "",
    },
    {
      "image": Images.lucas,
      "text1": "Lucas ",
      "text2": "UPI ID: 1234567890@DigiWallet",
      "text3": "",
    },
    {
      "image": Images.maya,
      "text1": "Maya",
      "text2": "UPI ID: 1234567890@DigiWallet",
      "text3": "",
    },
    {
      "image": Images.peterson,
      "text1": "Peterson",
      "text2": "UPI ID: 1234567890@DigiWallet",
      "text3": "",
    },
  ];

  static List<Map> enterUpiIdRecentList = [
    {
      "image": Images.jason,
      "text1": "Jason Adam",
      "text2": "UPI ID: 1234567890@DigiWallet",
    },
    {
      "image": Images.harry,
      "text1": "Harry Leo",
      "text2": "Bank Of Baroda A/c XX1234",
    },
    {
      "image": Images.maria,
      "text1": "Maria Sam",
      "text2": "UPI ID: 1234567890@DigiWallet",
    },
    {
      "image": Images.lucas,
      "text1": "Lucas ",
      "text2": "UPI ID: 1234567890@DigiWallet",
    },
    {
      "image": Images.maya,
      "text1": "Maya",
      "text2": "UPI ID: 1234567890@DigiWallet",
    },
    {
      "image": Images.peterson,
      "text1": "Peterson",
      "text2": "UPI ID: 1234567890@DigiWallet",
    },
    {
      "image": Images.jason,
      "text1": "Jason Adam",
      "text2": "UPI ID: 1234567890@DigiWallet",
    },
    {
      "image": Images.harry,
      "text1": "Harry Leo",
      "text2": "Bank Of Baroda A/c XX1234",
    },
  ];

  static List<Map> accountBalanceHistoryList = [
    {
      "image": Images.splashImage,
      "text1": "DigiWallet Balance",
      "text2": "Add money and get up to 10,000 Cashback Points",
      "text3": "₹1,000",
    },
    {
      "image": Images.bobImge,
      "text1": "Bank of Baroda 1234",
      "text2": "UPI Payments are received here",
      "text3": "Check Balance",
    },
    {
      "image": Images.manageBeneficiaries,
      "text1": "Personal Loan",
      "text2": "Get up to ₹3 lacs in 2 minutes!",
      "text3": "Apply Now",
    },
  ];

  static List<Map> accountBalanceTransactionHistoryList = [
    {
      "image": Images.jason,
      "text1": "Money sent Jason Adam",
      "text2": "- ₹,1000",
    },
    {
      "image": Images.harry,
      "text1": "Received from Harry Leo",
      "text2": "+ ₹,1000",
    },
    {
      "image": Images.maria,
      "text1": "Money sent Maria Sam",
      "text2": "- ₹,1000",
    },
  ];

  static List<Map> accountBalanceYesterdayHistoryList = [
    {
      "image": Images.lucas,
      "text": "Paid to Lucas ",
    },
    {
      "image": Images.maya,
      "text": "Money sent Maya",
    },
    {
      "image": Images.peterson,
      "text": "Money sent Peterson",
    },
  ];

  static List<Map> popularTagsList = [
    {
      "text": "Horror",
    },
    {
      "text": "Adventures",
    },
    {
      "text": "Korean Film",
    },
    {
      "text": "Action",
    },
    {
      "text": "Family Friendly",
    },
  ];

  static List<Map> mobileRechargeSelectContactList = [
    {
      "image": Images.maria,
      "text1": "Maria Sam",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.lucas,
      "text1": "Lucas ",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.maya,
      "text1": "Maya",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.mandy,
      "text1": "Mandy Lin",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.peterson,
      "text1": "Peterson",
      "text2": "+91 12345 67890",
    },
    {
      "image": Images.jason,
      "text1": "Jason Adam",
      "text2": "+91 12345 67890",
    },
  ];

  static List<Map> selectYourPrepaidOperatorList = [
    {
      "image": Images.airtel,
      "text": "Airtel Prepaid",
    },
    {
      "image": Images.bsnl,
      "text": "BSNL Prepaid",
    },
    {
      "image": Images.jio,
      "text": "Jio Prepaid",
    },
    {
      "image": Images.mtnl,
      "text": "MTNL Prepaid",
    },
    {
      "image": Images.vi,
      "text": "Vi Prepaid",
    },
  ];

  static List<Map> selectYourPostpaidOperator2List = [
    {
      "image": Images.airtel,
      "text": "Airtel Postpaid",
    },
    {
      "image": Images.bsnl,
      "text": "BSNL Postpaid",
    },
    {
      "image": Images.jio,
      "text": "Jio Postpaid",
    },
    {
      "image": Images.mtnl,
      "text": "MTNL DOLPHIN Postpaid",
    },
    {
      "image": Images.mtnl,
      "text": "MTNL DOLPHIN Postpaid",
    },
    {
      "image": Images.mtnl,
      "text": "MTNL DOLPHIN Postpaid",
    },
    {
      "image": Images.vi,
      "text": "Vi Postpaid",
    },
  ];

  static List selectYourCircle2List = [
    "All Circles",
    "Andhra Pradesh",
    "Assam",
    "Bihar Jharkhand",
    "Chennai",
    "Delhi NCR",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu Kashmir",
    "Karnataka",
    "Kerala",
    "Kolkata",
    "Madhya Pradesh Chhattisgarh",
    "Maharashtra",
    "Mumbai",
    "North East",
    "Orissa",
  ];

  static List prepaidOperatorDetailList = [
    "₹299",
    "₹479",
    "₹901",
    "₹699",
    "₹719",
    "₹499",
  ];

  static List<Map> selectDthOperatorList = [
    {
      "image": Images.airtelImage,
      "text": "Airtel Digital TV",
    },
    {
      "image": Images.dishTv,
      "text": "Dish TV",
    },
    {
      "image": Images.sunDirect,
      "text": "Sun Direct",
    },
    {
      "image": Images.tataPlay,
      "text": "Tata Play (Formerly Tatsuya)",
    },
    {
      "image": Images.d2h,
      "text": "D2H",
    },
  ];

  static List<Map> selectCableTvOperatorList = [
    {
      "image": Images.act,
      "text": "ACT Digital TV",
    },
    {
      "image": Images.asianet,
      "text": "Asianet Digital TV",
    },
    {
      "image": Images.stplAndGtpl,
      "text": "STPL CATV Lco Wallet Top Up",
    },
    {
      "image": Images.stplAndGtpl,
      "text": "GTPL Cable TV",
    },
    {
      "image": Images.hathway,
      "text": "Hathway",
    },
    {
      "image": Images.icc,
      "text": "ICC Network",
    },
    {
      "image": Images.inDigital,
      "text": "InDigital",
    },
    {
      "image": Images.nxtDigital,
      "text": "NXTDigital",
    },
    {
      "image": Images.scc,
      "text": "SCC Digital TV",
    },
    {
      "image": Images.sangliMedia,
      "text": "Sangli Media communication",
    },
    {
      "image": Images.usn,
      "text": "UCN TV",
    },
    {
      "image": Images.vdv,
      "text": "VDV Digital",
    },
  ];

  static List flightList = [
    "Round Trip",
    "One Way",
  ];

  static List<Map> selectYourMetroList = [
    {
      "image": Images.bengaluru,
      "text": "Bengaluru Metro",
    },
    {
      "image": Images.delhi,
      "text": "Delhi Metro",
    },
    {
      "image": Images.hyderabad,
      "text": "Hyderabad Metro",
    },
    {
      "image": Images.mumbai,
      "text": "Mumbai Metro",
    },
  ];

  static List offerList = [
    Images.offerImage3,
    Images.offerImage4,
    Images.offerImage5,
  ];

  static List<Map> selectYourFastagList = [
    {
      "image": Images.airtelPayment,
      "text": "Airtel Payments Bank",
    },
    {
      "image": Images.axixBank,
      "text": "Axis Bank",
    },
    {
      "image": Images.bankOfBaroda,
      "text": "Bank of Baroda",
    },
    {
      "image": Images.bankOfMaharashtra,
      "text": "Bank of Maharashtra FASTag",
    },
    {
      "image": Images.equitas,
      "text": "Equitas Small Finance Bank",
    },
    {
      "image": Images.federal,
      "text": "Federal Bank",
    },
    {
      "image": Images.hdfcBank,
      "text": "HDFC Bank",
    },
    {
      "image": Images.icicBank,
      "text": "ICICI Bank",
    },
    {
      "image": Images.idbi,
      "text": "IDBI Bank",
    },
    {
      "image": Images.idfc,
      "text": "IDFC First Bank",
    },
    {
      "image": Images.iob,
      "text": "IOB Fastag",
    },
  ];

  static List moviesList = [
    Images.ema,
    Images.joker,
    Images.movieTitle,
    Images.raw,
  ];

  static List<Map> movies2List = [
    {
      "image": Images.robert,
      "text": "Robert De\nNero",
    },
    {
      "image": Images.jack,
      "text": "Jack\nNicholson",
    },
    {
      "image": Images.marlon,
      "text": "Marlon\nBrando",
    },
    {
      "image": Images.leonardo,
      "text": "Leonardo\nDiCaprio",
    },
  ];

  static List<Map> selectYourCalenderList = [
    {
      "text1": "15:05",
      "text2": "12 Seat available",
    },
    {
      "text1": "15:05",
      "text2": "10 Seat available",
    },
    {
      "text1": "16:55",
      "text2": "10 Seat available",
    },
    {
      "text1": "18:35",
      "text2": "10 Seat available",
    },
    {
      "text1": "19:15",
      "text2": "10 Seat available",
    },
    {
      "text1": "20:05",
      "text2": "10 Seat available",
    },
  ];

  static List<Map> recentPaymentList = [
    {
      "image": Images.jason,
      "text": "Jason",
    },
    {
      "image": Images.harry,
      "text": "Harry",
    },
    {
      "image": Images.mandy,
      "text": "Mandy",
    },
    {
      "image": Images.maria,
      "text": "Maria",
    },
    {
      "image": Images.harry,
      "text": "Harry",
    },
    {
      "image": Images.maria,
      "text": "Maria",
    },
    {
      "image": Images.jason,
      "text": "Jason",
    },
    {
      "image": Images.mandy,
      "text": "Mandy",
    },
  ];
}
