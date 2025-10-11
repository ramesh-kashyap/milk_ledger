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
  List<Map<String, dynamic>> sellers = [];
  List<Map<String, dynamic>> purchasers = [];

  @override
  void initState() {
    super.initState();
    _fetchBillReport(); // Load all by default
  }

  // ---------------- FETCH BILL REPORT ----------------
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
          sellers = (data["sellers"] as List).cast<Map<String, dynamic>>();
          purchasers = (data["purchasers"] as List).cast<Map<String, dynamic>>();
        });
      }
    } catch (e) {
      print("Error fetching bill report: $e");
    }
  }

  // ---------------- DATE RANGE PICKER ----------------
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
        ? "Select Date Range"
        : "${DateFormat("dd MMM").format(selectedRange!.start)} - ${DateFormat("dd MMM").format(selectedRange!.end)}";

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: const Text("Bill Report", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range, color: Colors.white),
            onPressed: () => _selectDateRange(context),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _fetchBillReport,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ---------------- DATE RANGE SELECTOR ----------------
            Center(
              child: GestureDetector(
                onTap: () => _selectDateRange(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.date_range,
                          color: Colors.white, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        rangeText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ================= SELLER SECTION =================
            buildTableHeader("Seller Report"),
            buildTableRow(
                ["Account Name", "Payment", "Due", "Product", "Total"],
                isHeader: true),

            if (sellers.isEmpty)
              buildTableRow(["No data", "-", "-", "-", "-"])
            else
              ...sellers.map((t) => buildTableRow([
                    t["account_name"] ?? "-",
                    "₹${t["payment"]}",
                    "₹${t["due"]}",
                    "₹${t["product"]}",
                    "₹${t["total"]}",
                  ])),

            if (sellers.isNotEmpty) buildSummaryRow(sellers),

            const SizedBox(height: 20),

            // ================= PURCHASER SECTION =================
            buildTableHeader("Purchaser Report"),
            buildTableRow(
                ["Account Name", "Payment", "Due", "Product", "Total"],
                isHeader: true),

            if (purchasers.isEmpty)
              buildTableRow(["No data", "-", "-", "-", "-"])
            else
              ...purchasers.map((t) => buildTableRow([
                    t["account_name"] ?? "-",
                    "₹${t["payment"]}",
                    "₹${t["due"]}",
                    "₹${t["product"]}",
                    "₹${t["total"]}",
                  ])),

            if (purchasers.isNotEmpty) buildSummaryRow(purchasers),

            const SizedBox(height: 20),

            // ---------------- FOOTER ----------------
            Center(
              child: Text(
                "DoodhBazzar".tr,
                style: const TextStyle(
                    color: Colors.green, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER TEXT ----------------
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

  // ---------------- TABLE ROW ----------------
  Widget buildTableRow(List<String> values,
      {bool isHeader = false, bool highlight = false}) {
    return Container(
      decoration: BoxDecoration(
        color: highlight
            ? Colors.grey[200]
            : isHeader
                ? Colors.green[100]
                : Colors.transparent,
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

  // ---------------- SUMMARY TOTAL ROW ----------------
  Widget buildSummaryRow(List<Map<String, dynamic>> list) {
    double totalPayment = 0, totalDue = 0, totalProduct = 0, totalAmount = 0;

    for (var t in list) {
      totalPayment += double.tryParse(t["payment"].toString()) ?? 0;
      totalDue += double.tryParse(t["due"].toString()) ?? 0;
      totalProduct += double.tryParse(t["product"].toString()) ?? 0;
      totalAmount += double.tryParse(t["total"].toString()) ?? 0;
    }

    return buildTableRow([
      "Total (${list.length})",
      "₹${totalPayment.toStringAsFixed(2)}",
      "₹${totalDue.toStringAsFixed(2)}",
      "₹${totalProduct.toStringAsFixed(2)}",
      "₹${totalAmount.toStringAsFixed(2)}",
    ], highlight: true);
  }
}
