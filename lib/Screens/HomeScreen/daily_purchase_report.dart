import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart'; 
import 'package:dio/dio.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

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
  bool loading = false;

  List<dynamic> allEntries = [];
  List<dynamic> filteredEntries = [];

  final List<String> sessionOptions = ["Both", "Morning", "Evening"];
  final List<String> milkTypeOptions = ["Both", "Cow", "Buffalo"];

  @override
  void initState() {
    super.initState();
    fetchAllEntries();
  }

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
        _applyFilters();
      });
    }
  }

  Future<void> fetchAllEntries() async {
    setState(() => loading = true);
    try {
      final res = await ApiService.get('/dairypurchase'); // fetch all user entries
    //  print(res);
      allEntries = res.data['entries'] ?? [];
      _applyFilters();
      setState(() => loading = false);
    } catch (e) {
      print("Error fetching entries: $e");
      setState(() => loading = false);
    }
  }

void _applyFilters() {
  final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);

  filteredEntries = allEntries.where((entry) {
    // ✅ Use createdAt (not created_at)
    final entryDate = DateTime.parse(entry['createdAt']);
    final entryDateStr = DateFormat('yyyy-MM-dd').format(entryDate);

    bool dateMatch = entryDateStr == dateStr;

    // Match session correctly (AM/PM)
    String session = entry['session'].toString().toUpperCase();
    String selected = selectedSession == "Both"
        ? session
        : selectedSession == "Morning"
            ? "AM"
            : "PM";

    bool sessionMatch = session == selected;

    bool milkTypeMatch = selectedMilkType == "Both" ||
        entry['animal'].toString().toLowerCase() ==
            selectedMilkType.toLowerCase();

    return dateMatch && sessionMatch && milkTypeMatch;
  }).toList();
}


 Widget _buildEntryCard(Map entry) {
  return Container(
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 4,
          offset: const Offset(0, 2),
        )
      ],
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          // ✅ Fix createdAt
        child: Text(DateFormat('hh:mm a')
              .format(DateTime.parse(entry['createdAt']))),
        ),
        Expanded(flex: 1, child: Text("${entry['customer_id'] ?? '0'}")),
        Expanded(flex: 1, child: Text("${entry['litres'] ?? '0'} L")),
        Expanded(flex: 1, child: Text("₹ ${entry['amount'] ?? '0'}")),
        Expanded(flex: 1, child: Text(entry['animal']?.toString().toUpperCase() ?? '')),
        Expanded(flex: 1, child: Text(entry['session']?.toString() ?? '')),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    final totalLitres = filteredEntries.fold<double>(
    0, (sum, entry) => sum + double.parse(entry['litres'] ?? "0"));
    final totalAmount = filteredEntries.fold<double>(
    0, (sum, entry) => sum + double.parse(entry['amount'] ?? "0"));
    final totalFat = filteredEntries.fold<double>(
    0, (sum, entry) => sum + double.parse(entry['fat'] ?? "0"));
    final totalRate = filteredEntries.fold<double>(
    0, (sum, entry) => sum + double.parse(entry['rate'] ?? "0"));
    // final customerId = filteredEntries.fold<double>(
    // 0, (sum, entry) => sum + double.parse(entry['customer_id'] ?? "0"));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        elevation: 0,
        title: Text(
           "daily_purchase_report".tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<String>(        // 💚 Language switcher
            onSelected: (value) {
              if (value == 'en') {
                Get.updateLocale(const Locale('en', 'US'));
              } else if (value == 'hi') {
                Get.updateLocale(const Locale('hi', 'IN'));
              } else if (value == 'pa') {
                Get.updateLocale(const Locale('pa', 'IN'));
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'en', child: Text("English")),
              const PopupMenuItem(value: 'hi', child: Text("हिंदी")),
              const PopupMenuItem(value: 'pa', child: Text("ਪੰਜਾਬੀ")),
            ],
            icon: const Icon(Icons.language, color: Colors.white),
          ),
          IconButton(
            onPressed: fetchAllEntries,
            icon: const Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            InkWell(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down, color: Colors.green),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedSession,
                    decoration: InputDecoration(labelText: "session".tr),
                    items: sessionOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSession = value!;
                        _applyFilters();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedMilkType,
                    decoration: InputDecoration(labelText: "milk_type".tr),
                    items: milkTypeOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e.tr)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMilkType = value!;
                        _applyFilters();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
  child: loading
      ? const Center(child: CircularProgressIndicator())
      : filteredEntries.isEmpty
          ? Center(child: Text("no_entries_found".tr))
          : ListView.builder(
              itemCount: filteredEntries.length + 2, // +1 for header +1 for totals
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Header row
                  return Container(
                    color: Colors.green[400],
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    child: Row(
                      children: const [
                        Expanded(flex: 1, child: Text("Ac No", style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 1, child: Text("Milk", style: TextStyle(fontWeight: FontWeight.bold))),
                        // Expanded(flex: 1, child: Text("Amount", style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 1, child: Text("Fat", style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 1, child: Text("Rate", style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 1, child: Text("Amount", style: TextStyle(fontWeight: FontWeight.bold))),
                        // Expanded(flex: 1, child: Text("Session", style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  );
                }

                if (index == filteredEntries.length + 1) {
                  // Totals row
                  return Container(
                    color: Colors.green[400],
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    child: Row(
                      children: [
                        const Expanded(flex: 1, child: Text("TOTAL", style: TextStyle(fontWeight: FontWeight.bold))),
                        // Expanded(flex: 1, child: Text("$totalLitres L", style: const TextStyle(fontWeight: FontWeight.bold))), 
                        Expanded(flex: 1, child: Text("$totalLitres L", style: const TextStyle(fontWeight: FontWeight.bold))),                         
                        Expanded(flex: 1, child: Text("$totalFat L", style: const TextStyle(fontWeight: FontWeight.bold))), 
                        Expanded(flex: 1, child: Text("$totalRate L", style: const TextStyle(fontWeight: FontWeight.bold))),                         
                        Expanded(flex: 1, child: Text("₹ $totalAmount", style: const TextStyle(fontWeight: FontWeight.bold))),                        
                        // const Expanded(flex: 1, child: SizedBox()),
                        // const Expanded(flex: 1, child: SizedBox()),
                      ],
                    ),
                  );
                }

                final entry = filteredEntries[index - 1];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                  child: Row(
                    children: [
                      // Expanded(
                      //   flex: 2,
                      //   child: Text(DateFormat('hh:mm a').format(DateTime.parse(entry['createdAt']))),
                      // ),
                      // Expanded(
                      //   flex: 1,
                      //   child: Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(entry['createdAt']))),
                      // ),
                      // Expanded(flex: 1, child: Text("${entry['customer_id'] ?? '0'}")),
                      Expanded(flex: 1, child: Text("${entry['customer_id'] ?? '0'}")),
                      Expanded(flex: 1, child: Text("${entry['litres'] ?? '0'} L")),                      
                      Expanded(flex: 1, child: Text("${entry['fat'] ?? '0'}")),
                      Expanded(flex: 1, child: Text("${entry['Rate'] ?? '0'}")),
                      Expanded(flex: 1, child: Text("₹ ${entry['amount'] ?? '0'}")),
                      // Expanded(flex: 1, child: Text(entry['animal']?.toString().toUpperCase() ?? '')),
                      // Expanded(flex: 1, child: Text(entry['session']?.toString() ?? '')),
                      
                    ],
                  ),
                );
              },
            ),
),


          ],
        ),
      ),
    );
  }
}
