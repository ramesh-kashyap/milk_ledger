import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTimeRange? selectedRange;

  List<Map<String, dynamic>> transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchBillReport(); // load all by default
  }

  Future<void> _fetchBillReport() async {
    try {
      final body = <String, dynamic>{};

      if (selectedRange != null) {
        body["from"] = DateFormat("yyyy-MM-dd").format(selectedRange!.start);
        body["to"] = DateFormat("yyyy-MM-dd").format(selectedRange!.end);
      }

      final response = await ApiService.post("/billreport", body);
      final data = response.data;

      if (data["success"] == true) {
        setState(() {
          transactions = (data["data"] as List).cast<Map<String, dynamic>>();
        });
      }
    } catch (e) {
      print("Error fetching bill report: $e");
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      initialDateRange: selectedRange,
    );
    if (picked != null) {
      setState(() {
        selectedRange = picked;
      });
      _fetchBillReport();
    }
  }

  @override
  Widget build(BuildContext context) {
    final rangeText = selectedRange == null
        ? "select_date_range".tr
        : "${DateFormat("dd MMM").format(selectedRange!.start)} - ${DateFormat("dd MMM").format(selectedRange!.end)}";

    // Sellers: only pay rows
    final sellers = transactions
        .where((t) => t["type"] == "pay")
        .toList();

    // Purchasers: only receive rows
    final purchasers = transactions
        .where((t) => t["type"] == "receive")
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text(
          "report".tr, 
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range, color: Colors.white),
            onPressed: () => _selectDateRange(context),
          ),
          IconButton(
            icon: const Icon(Icons.print, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date Range Header
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  rangeText,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Date & Timestamp
            Container(
              padding: const EdgeInsets.all(4),
              color: Colors.green[100],
              child: Text(
                DateFormat("EEE yyyy MMM dd HH:mm:ss").format(DateTime.now()),
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              selectedRange == null
                  ? "no_date_range_selected".tr
                  : "${DateFormat("dd MMM yyyy").format(selectedRange!.start)} to ${DateFormat("dd MMM yyyy").format(selectedRange!.end)}",
              style: const TextStyle(fontSize: 13, color: Colors.black87),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Sellers Table
            buildTableHeader("seller".tr),
            buildTableRow(
                 ["ac_no".tr, "name".tr, "send".tr], 
                isHeader: true),
            ...sellers.map((t) => buildTableRow([
                  t["Customer.code"] ?? "",
                  t["Customer.name"] ?? "",
                  (t["totalAmount"] ?? "0").toString(),
                ])),
            buildTableRow([
               "total".tr + "(${sellers.length})",
              "",
              sellers.fold<double>(
                      0,
                      (sum, t) =>
                          sum + double.parse(t["totalAmount"].toString()))
                  .toStringAsFixed(2),
            ]),

            const SizedBox(height: 20),

            // Purchasers Table
            buildTableHeader("purchaser".tr), 
            buildTableRow(
                ["ac_no".tr, "name".tr, "receive".tr], 
                isHeader: true),
            ...purchasers.map((t) => buildTableRow([
                  t["Customer.code"] ?? "",
                  t["Customer.name"] ?? "",
                  (t["totalAmount"] ?? "0").toString(),
                ])),
            buildTableRow([
              "total".tr + "(${purchasers.length})",
              "",
              purchasers.fold<double>(
                      0,
                      (sum, t) =>
                          sum + double.parse(t["totalAmount"].toString()))
                  .toStringAsFixed(2),
            ]),

            const SizedBox(height: 20),

             Center(
              child: Text(
                "doodhbazzar".tr,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTableHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildTableRow(List<String> values,
      {bool isHeader = false, bool highlight = false}) {
    return Container(
      decoration: BoxDecoration(
        color: highlight ? Colors.grey[200] : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade400, width: 0.8),
        ),
      ),
      child: Row(
        children: values
            .map(
              (v) => Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  child: Text(
                    v,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
