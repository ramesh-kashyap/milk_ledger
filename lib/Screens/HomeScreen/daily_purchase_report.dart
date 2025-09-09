import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyPurchaseReportScreen extends StatefulWidget {
  const DailyPurchaseReportScreen({super.key});

  @override
  State<DailyPurchaseReportScreen> createState() =>
      _DailyPurchaseReportScreenState();
}

class _DailyPurchaseReportScreenState extends State<DailyPurchaseReportScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedSession = "Both";
  String selectedMilkType = "Both";

  final List<String> sessionOptions = ["Both", "Morning", "Evening"];
  final List<String> milkTypeOptions = ["Both", "Cow", "Buffalo"];

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        elevation: 0,
        title: const Text(
          "Daily purchase report",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Print / Share function
            },
            icon: const Icon(Icons.print, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Date Picker
            InkWell(
              onTap: _pickDate,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green, width: 1.5),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.green),
                    const SizedBox(width: 12),
                    Text(
                      DateFormat('yyyy-MM-dd').format(selectedDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Dropdowns Row
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedSession,
                    decoration: InputDecoration(
                      labelText: "Session",
                      labelStyle: const TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.green, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.green, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: sessionOptions
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSession = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedMilkType,
                    decoration: InputDecoration(
                      labelText: "Milk Type",
                      labelStyle: const TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.green, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.green, width: 1.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: milkTypeOptions
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMilkType = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
