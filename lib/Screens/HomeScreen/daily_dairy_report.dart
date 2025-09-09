import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DairyReportScreen extends StatelessWidget {
  const DairyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat('dd MMM yyyy').format(DateTime.now());
    String monthYear = DateFormat('MMM yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Dairy Report",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.green[50],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildReportCard("Today ($todayDate)", Icons.calendar_today),
              const SizedBox(height: 16),
              _buildReportCard(monthYear, Icons.calendar_month),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, IconData icon) {
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
          _buildRow("Total Purchase", "0.00 L", "₹ 0.00"),
          _buildRow("Total Sale", "0.00 L", "₹ 0.00"),
          _buildRow("Total", "0.00 L", "₹ 0.00"),
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
            child: Text(label, style: const TextStyle(fontSize: 14)),
          ),
          Expanded(
            flex: 1,
            child: Text(
              liters,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              amount,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
