import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:digitalwalletpaytmcloneapp/Service/Api.dart';

class DailyPurchaseReportScreen extends StatefulWidget {
  const DailyPurchaseReportScreen({super.key});

  @override
  State<DailyPurchaseReportScreen> createState() =>
      _DailyPurchaseReportScreenState();
}

class _DailyPurchaseReportScreenState
    extends State<DailyPurchaseReportScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedSession = "Both";
  String selectedMilkType = "Both";
  bool loading = false;

  List<dynamic> allEntries = [];
  List<dynamic> morningEntries = [];
  List<dynamic> eveningEntries = [];
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
      final res = await ApiService.get('/dairypurchase');
      allEntries = res.data['entries'] ?? [];
      _applyFilters();
    } catch (e) {
      print("Error fetching entries: $e");
    } finally {
      setState(() => loading = false);
    }
  }

  void _applyFilters() {
    final dateStr = DateFormat('yyyy-MM-dd').format(selectedDate);

    List<dynamic> dateFiltered = allEntries.where((entry) {
      final entryDate = DateTime.parse(entry['createdAt']);
      final entryDateStr = DateFormat('yyyy-MM-dd').format(entryDate);
      bool dateMatch = entryDateStr == dateStr;

      bool milkTypeMatch = selectedMilkType == "Both" ||
          entry['animal'].toString().toLowerCase() ==
              selectedMilkType.toLowerCase();

      return dateMatch && milkTypeMatch;
    }).toList();

    morningEntries = dateFiltered
        .where((e) => e['session'].toString().toUpperCase() == "AM")
        .toList();
    eveningEntries = dateFiltered
        .where((e) => e['session'].toString().toUpperCase() == "PM")
        .toList();

    if (selectedSession == "Morning") {
      filteredEntries = morningEntries;
    } else if (selectedSession == "Evening") {
      filteredEntries = eveningEntries;
    } else {
      filteredEntries = dateFiltered;
    }

    setState(() {});
  }

  Widget _buildHeaderRow() => Container(
        color: Colors.green[400],
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: const Row(
          children: [
            Expanded(flex: 1, child: Text("Ac No", style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 1, child: Text("Milk", style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 1, child: Text("Fat", style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 1, child: Text("Rate", style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(flex: 1, child: Text("Amount", style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
      );

  Widget _buildRow(Map entry) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        child: Row(
          children: [
            Expanded(flex: 1, child: Text("${entry['customer_id'] ?? '0'}")),
            Expanded(flex: 1, child: Text("${entry['litres'] ?? '0'}")),
            Expanded(flex: 1, child: Text("${entry['fat'] ?? '0'}")),
            Expanded(flex: 1, child: Text("${entry['rate'] ?? '0'}")),
            Expanded(flex: 1, child: Text("${entry['amount'] ?? '0'}")),
          ],
        ),
      );

  Widget _buildListSection(String title, List<dynamic> entries) {
    final totalLitres = entries.fold<double>(
        0, (sum, entry) => sum + double.parse(entry['litres'] ?? "0"));
    final totalAmount = entries.fold<double>(
        0, (sum, entry) => sum + double.parse(entry['amount'] ?? "0"));
    final totalFat = entries.fold<double>(
        0, (sum, entry) => sum + double.parse(entry['fat'] ?? "0"));
    final totalRate = entries.fold<double>(
        0, (sum, entry) => sum + double.parse(entry['rate'] ?? "0"));

    return Card(
      margin: const EdgeInsets.only(top: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green)),
            const SizedBox(height: 8),
            _buildHeaderRow(),
            ...entries.map((e) => _buildRow(e)).toList(),
            Container(
              color: Colors.green[400],
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                children: [
                  const Expanded(
                      flex: 1,
                      child: Text("TOTAL",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 1,
                      child: Text("$totalLitres",
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 1,
                      child: Text("$totalFat",
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 1,
                      child: Text("$totalRate",
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 1,
                      child: Text("₹ $totalAmount",
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text("daily_purchase_report".tr,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<String>(
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
              icon: const Icon(Icons.refresh, color: Colors.white)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
                    Text(DateFormat('yyyy-MM-dd').format(selectedDate),
                        style: const TextStyle(fontSize: 16)),
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
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.tr)))
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
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.tr)))
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
                  : selectedSession == "Both"
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildListSection("Morning Data (AM)", morningEntries),
                              _buildListSection("Evening Data (PM)", eveningEntries),
                            ],
                          ),
                        )
                      : filteredEntries.isEmpty
                          ? Center(child: Text("no_entries_found".tr))
                          : SingleChildScrollView(
                              child: _buildListSection(
                                selectedSession == "Morning"
                                    ? "Morning Data (AM)"
                                    : "Evening Data (PM)",
                                filteredEntries,
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
