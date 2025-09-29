import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';
import 'package:get/get.dart';
class DairyReportScreen extends StatefulWidget {
  const DairyReportScreen({super.key});

  @override
  State<DairyReportScreen> createState() => _DairyReportScreenState();
}

class _DairyReportScreenState extends State<DairyReportScreen> {
  Map<String, dynamic>? reportData;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchReport();
  }

  // Fetch API data
  Future<void> fetchReport() async {
    try {
      final resp = await ApiService.get('/dairyreport'); // Your API call
      final res = resp.data;
      print(res);
      setState(() {
        reportData = res as Map<String, dynamic>;
        loading = false;
      });
    } catch (e) {
      print("Error fetching report: $e");
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "dairy_report".tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.green[10],
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // ✅ Today report
                      if (reportData?['today'] != null)
                        _buildReportCard(
                          "${'today'.tr} ($todayDate)",
                          Icons.calendar_today,
                          {
                            "purchaseLitres": double.tryParse(reportData!['today']['litres']?.toString() ?? "0") ?? 0.0,
                            "purchaseAmount": double.tryParse(reportData!['today']['amount']?.toString() ?? "0") ?? 0.0,
                            "saleLitres": 0.0, // backend not splitting buy/sale for today
                            "saleAmount": 0.0,
                          },
                        ),
                      const SizedBox(height: 16),

                      // ✅ Monthly reports
                      if (reportData?['months'] != null)
                        ...(() {
                          List<Map<String, dynamic>> months =
                              (reportData!['months'] as List).cast<Map<String, dynamic>>();

                          // Sort by year & month descending
                          months.sort((a, b) {
                            int yearComp = (b['year'] as int).compareTo(a['year'] as int);
                            return yearComp != 0
                                ? yearComp
                                : (b['month'] as int).compareTo(a['month'] as int);
                          });

                          // Group months by year+month
                          Map<String, Map<String, dynamic>> grouped = {};
                          for (var m in months) {
                            String key = "${m['year']}-${m['month']}";
                            if (!grouped.containsKey(key)) {
                              grouped[key] = {
                                "year": m['year'],
                                "month": m['month'],
                                "month_name": m['month_name'],
                                "purchaseLitres": 0.0,
                                "purchaseAmount": 0.0,
                                "saleLitres": 0.0,
                                "saleAmount": 0.0,
                              };
                            }

                            if (m['note'] == "Buy") {
                              grouped[key]!["purchaseLitres"] +=
                                  double.tryParse(m['litres'].toString()) ?? 0.0;
                              grouped[key]!["purchaseAmount"] +=
                                  double.tryParse(m['amount'].toString()) ?? 0.0;
                            } else if (m['note'] == "Sale") {
                              grouped[key]!["saleLitres"] +=
                                  double.tryParse(m['litres'].toString()) ?? 0.0;
                              grouped[key]!["saleAmount"] +=
                                  double.tryParse(m['amount'].toString()) ?? 0.0;
                            }
                          }

                          // Map to widgets
                          return grouped.values.map((monthData) {
                            final title =
                                "${monthData['month_name']} ${monthData['year']}";
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _buildReportCard(
                                title,
                                Icons.calendar_month,
                                monthData,
                              ),
                            );
                          }).toList();
                        })(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  // Build each card (Today / Month)
  Widget _buildReportCard(String title, IconData icon, Map<String, dynamic> data) {
    double purchaseLitres = data['purchaseLitres'] ?? 0.0;
    double purchaseAmount = data['purchaseAmount'] ?? 0.0;
    double saleLitres = data['saleLitres'] ?? 0.0;
    double saleAmount = data['saleAmount'] ?? 0.0;

    double totalLitres = purchaseLitres + saleLitres;
    double totalAmount = purchaseAmount + saleAmount;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.green, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          _buildRow("total_purchase".tr,
              "${purchaseLitres.toStringAsFixed(2)} L", "₹ ${purchaseAmount.toStringAsFixed(2)}"),
          _buildRow("total_sale".tr,
              "${saleLitres.toStringAsFixed(2)} L", "₹ ${saleAmount.toStringAsFixed(2)}"),
          _buildRow("total".tr,
              "${totalLitres.toStringAsFixed(2)} L", "₹ ${totalAmount.toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String liters, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(label, style: const TextStyle(fontSize: 14))),
          Expanded(
              flex: 1,
              child: Text(liters,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500))),
          Expanded(
              flex: 1,
              child: Text(amount,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
