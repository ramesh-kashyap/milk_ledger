import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: const Text(
          "Report",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.arrow_back_ios, color: Colors.green),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "1-31 Aug",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.green),
              ],
            ),
            const SizedBox(height: 10),

            // Date & Timestamp
            Container(
              padding: const EdgeInsets.all(4),
              color: Colors.green[100],
              child: const Text(
                "Fri 2025 Sep 12 15:27:49",
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "01 Aug 2025 to 31 Aug 2025",
              style: TextStyle(fontSize: 13, color: Colors.black87),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Sellers Table
            buildTableHeader("Sellers"),
            buildTableRow(["Ac No", "Payments", "Due", "Sale/\nPurchase", "Total"],
                isHeader: true),
            buildTableRow(["Total(0)", "0.00", "0.00", "0.00", "0.00"]),

            const SizedBox(height: 20),

            // Purchasers Table
            buildTableHeader("Purchasers"),
            buildTableRow(["Ac No", "Payments", "Due", "Sale/\nPurchase", "Total"],
                isHeader: true),
            buildTableRow(["080\nSachin", "0.00", "0.00", "0.00", "0.00"],
                highlight: true),
            buildTableRow(["Total(1)", "0.00", "0.00", "0.00", "0.00"]),

            const SizedBox(height: 20),

            // Footer
            const Center(
              child: Text(
                "Santosh Lassi Vila",
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

  // Table header widget
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

  // Table row widget
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
                      fontSize: isHeader ? 13 : 13,
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
