import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

  final box = GetStorage(); // ✅ Access stored duration
  int durationDays = 5; // default duration
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // ✅ Get duration from Settings
    durationDays = box.read('duration') ?? 5;

    final now = DateTime.now();
    selectedRange = DateTimeRange(
      start: now.subtract(Duration(days: durationDays)),
      end: now,
    );

    _fetchBillReport();
  }

  // ✅ Re-fetch report if duration changes in Settings
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    int newDuration = box.read('duration') ?? 5;
    if (newDuration != durationDays) {
      setState(() {
        durationDays = newDuration;
        final now = DateTime.now();
        selectedRange = DateTimeRange(
          start: now.subtract(Duration(days: durationDays)),
          end: now,
        );
      });
      _fetchBillReport();
    }
  }

  // ---------------- FETCH BILL REPORT ----------------
  Future<void> _fetchBillReport() async {
    try {
      setState(() => isLoading = true);

      final body = <String, dynamic>{};
      if (selectedRange != null) {
        body["from"] = DateFormat("yyyy-MM-dd").format(selectedRange!.start);
        body["to"] = DateFormat("yyyy-MM-dd").format(selectedRange!.end);
      }

      print("Fetching Bill Report: $body");

      final response = await ApiService.post("/billreport", body);
      print("Bill Report Response: ${response.data}");

      final data = response.data;
      if (data["success"] == true) {
        setState(() {
          sellers = (data["sellers"] as List).cast<Map<String, dynamic>>();
          purchasers = (data["purchasers"] as List).cast<Map<String, dynamic>>();
        });
      }
    } catch (e) {
      print("Error fetching bill report: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  // ---------------- DATE RANGE PICKER (manual change) ----------------
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

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text('bill_report'.tr, style: const TextStyle(color: Colors.white)),
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ---------------- DATE RANGE DISPLAY ----------------
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'last_days_range'.trParams({
                          'days': durationDays.toString(),
                          'range': rangeText,
                        }),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ================= SELLER SECTION =================
                  buildTableHeader("seller_report".tr),
                  buildTableRow(
                    ["account_name".tr, "payment".tr, "due".tr, "product".tr, "total".tr],
                    isHeader: true,
                  ),

                  if (sellers.isEmpty)
                    buildTableRow(["No data", "-", "-", "-", "-"])
                  else
                    ...sellers.map((t) => buildTableRow([
                          "${t["account_name"] ?? "-"}${t["code"] != null && t["code"].toString().isNotEmpty ? " (${t["code"]})" : ""}",
                          "${t["payment"]}",
                          "${t["due"]}",
                          "${t["product"]}",
                          "${t["total"]}",
                        ])),

                  if (sellers.isNotEmpty) buildSummaryRow(sellers),

                  const SizedBox(height: 20),

                  // ================= PURCHASER SECTION =================
                  buildTableHeader('purchaser_report'.tr),
                  buildTableRow(
                    ["account_name".tr, "payment".tr, "due".tr, "product".tr, "total".tr],
                    isHeader: true,
                  ),

                  if (purchasers.isEmpty)
                    buildTableRow(["No data", "-", "-", "-", "-"])
                  else
                    ...purchasers.map((t) => buildTableRow([
                          "${t["account_name"] ?? "-"}${t["code"] != null && t["code"].toString().isNotEmpty ? " (${t["code"]})" : ""}",
                          "${t["payment"]}",
                          "${t["due"]}",
                          "${t["product"]}",
                          "${t["total"]}",
                        ])),

                  if (purchasers.isNotEmpty) buildSummaryRow(purchasers),

                  const SizedBox(height: 20),

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
      "${totalPayment.toStringAsFixed(2)}",
      "${totalDue.toStringAsFixed(2)}",
      "${totalProduct.toStringAsFixed(2)}",
      "${totalAmount.toStringAsFixed(2)}",
    ], highlight: true);
  }
}
